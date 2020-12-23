import 'dart:io';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:injectable/injectable.dart';

@singleton
class IPv6 {
  List<AddressCheckOptions> addresses;

  IPv6() {
    addresses = List.from(DataConnectionChecker.DEFAULT_ADDRESSES);
    addresses.addAll([
      AddressCheckOptions(
        InternetAddress('2001:4860:4860::8888', type: InternetAddressType.IPv6), // Google
        port: DataConnectionChecker.DEFAULT_PORT,
        timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
      ),
      AddressCheckOptions(
        InternetAddress('2001:4860:4860::8844', type: InternetAddressType.IPv6), // Google
        port: DataConnectionChecker.DEFAULT_PORT,
        timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
      ),
      AddressCheckOptions(
        InternetAddress('2606:4700:4700::64', type: InternetAddressType.IPv6), // CloudFlare
        port: DataConnectionChecker.DEFAULT_PORT,
        timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
      ),
      AddressCheckOptions(
        InternetAddress('2606:4700:4700::6400', type: InternetAddressType.IPv6), // CloudFlare
        port: DataConnectionChecker.DEFAULT_PORT,
        timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
      ),
      AddressCheckOptions(
        InternetAddress('2620:119:35::35', type: InternetAddressType.IPv6), // OpenDNS
        port: DataConnectionChecker.DEFAULT_PORT,
        timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
      ),
      AddressCheckOptions(
        InternetAddress('2620:119:53::53', type: InternetAddressType.IPv6), // OpenDNS
        port: DataConnectionChecker.DEFAULT_PORT,
        timeout: DataConnectionChecker.DEFAULT_TIMEOUT,
      ),
    ]);
  }
}
