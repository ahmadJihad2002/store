import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            condition: ShopCubit.get(context).homeModel != null,
            builder: (context) =>
                productBuilder(ShopCubit.get(context).homeModel),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget productBuilder(HomeModel? model) {
    return SingleChildScrollView(
      child: Column(
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
          Container(
            color: Colors.grey[100],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1 / 1.3,
              children: List.generate(model?.data.products.length ?? 0,
                  (index) => gridBuilder(model?.data.products[index])),
            ),
          )
        ],
      ),
    );
  }

  Widget gridBuilder(ProductModel? model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: model?.image ?? '',
          width: double.infinity,
          height: 200,
          fit: BoxFit.fill,
        ),
        Text(
          model?.name ?? "null",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            height: 1.1,
          ),
        ),
        Text('${model?.price.round()}',style: TextStyle(fontSize:12,color: Colors.red ),)
      ],
    );
  }
}
