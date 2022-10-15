import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/shop_app/categories_model.dart';
import 'package:untitled/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state)=>ListView.separated(
          physics: BouncingScrollPhysics() ,
          itemBuilder: (context,index)=>catList(ShopCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder:(context,index)=> myDivider(),
          itemCount: ShopCubit.get(context).categoriesModel!.data.data.length),
    );
  }
  Widget catList(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 80.0,
          width: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 40,),
        Text(
          model.name,
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20
          ),
        ),
        Spacer(),
        IconButton(onPressed: (){},
            icon: Icon(Icons.arrow_forward_ios))
      ],
    ),
  );
}
