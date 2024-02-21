import 'package:flutter/material.dart';
import 'package:flutter_ahlul_quran_app/contants.dart';
import 'package:flutter_ahlul_quran_app/cubit/surah/surah_cubit.dart';
import 'package:flutter_ahlul_quran_app/ui/ayat_page.dart';
import 'package:flutter_ahlul_quran_app/ui/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class surahPage extends StatefulWidget {
  const surahPage({super.key});

  @override
  State<surahPage> createState() => _surahPageState();
}

class _surahPageState extends State<surahPage> {
@override
  void initState() {
    context.read<SurahCubit>().getAllSurah();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Al Qur-an',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                context: context, 
                // delegate to customize the search bar
                delegate: CustomSearchDelegate(),

                
              );
            },
            icon: const Icon(Icons.search, color: Colors.white,),
          )
        ],
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: BlocBuilder<SurahCubit, SurahState>(builder: (context, state) {
          if (state is surahLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is surahLoaded) {
            return ListView.builder(itemBuilder: (context, index) {
              final surah = state.listSurah[index];
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return AyatPage(surah: surah);
                  },),);
                },
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Text('${surah.nomor}',style: const TextStyle(
                        color: AppColors.white
                      ),),
                    ),
                    title: Text('${surah.namaLatin}, ${surah.nama}'),
                    subtitle: Text('${surah.arti}, ${surah.jumlahAyat} ayat.'),
                  ),
                ),
              );
            },
            itemCount: state.listSurah.length,
            );
          }
          if (state is SurahError) {
            return Center(
              child: Text(state.message),
            );
          }

          return const Center(
            child: Text('no data'),
          );
        },
      ),
    );
    
  }
}