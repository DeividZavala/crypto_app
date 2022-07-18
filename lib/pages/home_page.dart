import 'package:crypto_app/blocs/crypto/crypto_bloc.dart';
import 'package:crypto_app/services/data_repo.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: const Text("Crypto App"),
        backgroundColor: const Color(0xff67316a),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff67316a), Color(0xff3549af)])),
        child: BlocBuilder<CryptoBloc, CryptoState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.loaded:
                return RefreshIndicator(
                    color: Theme.of(context).colorScheme.secondary,
                    onRefresh: () async {
                      context.read<CryptoBloc>().add(RefreshCoins());
                    },
                    child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          final coin = state.coins[index];
                          return Column(
                            children: [
                              ListTile(
                                title: Text(coin.fullName,
                                    style:
                                        const TextStyle(color: Colors.white)),
                                subtitle: Text(
                                  coin.name,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                trailing: Text(
                                  "\$${coin.price}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const Divider()
                            ],
                          );
                        },
                        itemCount: state.coins.length));
              case Status.error:
                return Center(
                  child: Text(
                    state.onError.message,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).colorScheme.secondary),
                ));
            }
          },
        ),
      ),
    ));
  }
}
