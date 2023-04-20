import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:Eb3tly/components/constants.dart';
import 'package:Eb3tly/components/dialogs.dart';
import 'package:Eb3tly/controllers/controllers.dart';
import 'package:Eb3tly/models/sender_model.dart';
import 'package:Eb3tly/services/sender.dart';
import 'package:qr_flutter/qr_flutter.dart';


class SharePage extends StatefulWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  SenderModel senderModel = PhotonSender.getServerInfo();
  PhotonSender photonSender = PhotonSender();
  late double width;
  late double height;
  bool willPop = false;
  var receiverDataInst = GetIt.I.get<ReceiverDataController>();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: ValueListenableBuilder(
          valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
          builder: (_, AdaptiveThemeMode mode, __) {
            return Scaffold(
                backgroundColor:  Colors.white,
                appBar: AppBar(
                  backgroundColor:
                       Colors.blue,
                  title: const Text('Share'),
                  leading: BackButton(
                      color: Colors.white,
                      onPressed: () {
                        sharePageAlertDialog(context);
                      }),
                  flexibleSpace: mode.isLight
                      ? Container(
                          decoration: appBarGradient,
                        )
                      : null,
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (width > 720) ...{
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [


                              SizedBox(
                                // width: width > 720 ? 200 : 100,
                                // height: width > 720 ? 200 : 100,
                                child: QrImage(
                                  size: 500,
                                  foregroundColor: Colors.black,
                                  data: PhotonSender.getPhotonLink,
                                  backgroundColor: Colors.white,
                                ),
                              )
                            ],
                          )
                        } else ...{

                          SizedBox(height: 150,),
                          Container(
                            alignment: Alignment.center,

                            child: QrImage(
                              size: 500,
                              foregroundColor: Colors.black,
                              data: PhotonSender.getPhotonLink,
                              backgroundColor: Colors.white,
                            ),
                          )
                        },
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 300,
                            child: Text(
                              '${photonSender.hasMultipleFiles ? 'Your files are ready to be shared' : 'Your file is ready to be shared'}\nAsk receiver to tap on receive button',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width > 720 ? 18 : 14,
                                color: Colors.black
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        //receiver data
                        Obx((() => GetIt.I
                                .get<ReceiverDataController>()
                                .receiverMap
                                .isEmpty
                            ? Card(
                                // color: mode.isDark
                                //     ? const Color.fromARGB(255, 29, 32, 34)
                                //     : const Color.fromARGB(255, 241, 241, 241),
                                // clipBehavior: Clip.antiAlias,
                                // elevation: 8,
                                // // color: Platform.isWindows ? Colors.grey.shade300 : null,
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(24)),
                                child: SizedBox(
                                  // height: width > 720 ? 200 : 128,
                                  // width: width > 720 ? width / 2 : width / 1.25,
                                  child: Center(
                                    // child: Wrap(
                                    //   direction: Axis.vertical,
                                    //   children: infoList(
                                    //       senderModel,
                                    //       width,
                                    //       height,
                                    //       true,
                                    //       mode.isDark ? "dark" : "bright"),
                                    // ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                width: width / 1.2,
                                child: Card(
                                  color: mode.isDark
                                      ? const Color.fromARGB(255, 45, 56, 63)
                                      : const Color.fromARGB(
                                          255, 241, 241, 241),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        receiverDataInst.receiverMap.length,
                                    itemBuilder: (context, item) {
                                      var keys = receiverDataInst
                                          .receiverMap.keys
                                          .toList();

                                      var data = receiverDataInst.receiverMap;

                                      return ListTile(
                                        title: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (item == 0) ...{
                                                const Center(
                                                  child: Text("Sharing status"),
                                                ),
                                              },
                                              const Divider(
                                                thickness: 2.4,
                                                indent: 20,
                                                endIndent: 20,
                                                color: Colors.blue,
                                              ),
                                              Center(
                                                child: Text(
                                                  "Receiver name : ${data[keys[item]]['hostName']}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              data[keys[item]]['isCompleted'] ==
                                                      'true'
                                                  ? const Center(
                                                      child: Text(
                                                        "All files sent",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    )
                                                  : Center(
                                                      child: Text(
                                                          "Sending '${data[keys[item]]['currentFileName']}' (${data[keys[item]]['currentFileNumber']} out of ${data[keys[item]]['filesCount']} files)",

                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ))),
                      ],
                    ),
                  ),
                ));
          }),
      onWillPop: () async {
        willPop = await sharePageWillPopDialog(context);
        GetIt.I.get<ReceiverDataController>().receiverMap.clear();
        return willPop;
      },
    );
  }
}
