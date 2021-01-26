import 'package:bitcoin_ticker/Networking.dart';

const apiKey = '141C4786-8EFA-41EE-88D3-74C05A551E12';
const openCoinApiURl = 'http://rest.coinapi.io/v1/exchangerate/';



class coinRateTransfer{
  String requestUrl = 'https://rest.coinapi.io/v1/exchangerate';
  final String coinFrom;
  final String coinTo;

  coinRateTransfer({this.coinFrom,this.coinTo});

  // var coinExchangeRate = await networkHelper.getData();
  Future getcoinRate() async{
    NetworkHelper networkHelper = NetworkHelper(url: '$requestUrl/$coinFrom/$coinTo/?apikey=$apiKey');
    var coinRate = await networkHelper.getData();
    return coinRate['rate'];
  }

  }
