import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash/models/shop_app/categories_models.dart';
import 'package:hash/models/shop_app/home_model.dart';
import 'package:hash/shared/cubit/shop_home_cubit/cubit.dart';
import 'package:hash/shared/cubit/shop_home_cubit/states.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => productBuilder(
                ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget productBuilder(HomeModel? model, CategoriesModel? categoriesModel) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                height: 300,
                pauseAutoPlayOnTouch: true,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                autoPlayCurve: Curves.fastOutSlowIn),
            items: model?.data.products.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: i.image ?? '',
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ));
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          categoriesBuilder(categoriesModel?.data, index),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10.0,
                          ),
                      itemCount: categoriesModel?.data.data.length ?? 0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'New products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[100],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1 / 1.55,
              children: List.generate(model?.data.products.length ?? 0,
                  (index) => gridBuilder(model?.data.products[index])),
            ),
          )
        ],
      ),
    );
  }

  Widget categoriesBuilder(CategoriesDataModel? categoriesModel, int index) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CachedNetworkImage(
              imageUrl: categoriesModel?.data[index].image ?? '',
              fit: BoxFit.cover,
              height: 100,
              width: 100,
            ),
            Container(
                width: 100,
                color: Colors.black.withOpacity(0.7),
                child: Text(
                  categoriesModel?.data[index].name ?? "null",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ))
          ],
        )
      ],
    );
  }

  Widget gridBuilder(ProductModel? model) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(alignment: Alignment.bottomLeft, children: [
            CachedNetworkImage(
              imageUrl: model?.image ?? '',
              width: double.infinity,
              height: 200,
              // fit: BoxFit.fill,
            ),
            if (model?.discount != 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                color: Colors.red,
                child: const Text('DISCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                    )),
              )
          ]),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model?.name ?? "null",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.1,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model?.price.round()}',
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if (model?.discount == 0)
                      Text(
                        '${model?.oldPrice.round()}',
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    IconButton(
                        padding: EdgeInsets.all(0.1),
                        onPressed: () {
                          print(model?.id);
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 15.0,
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
