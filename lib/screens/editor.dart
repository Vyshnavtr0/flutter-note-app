import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_selector/emoji_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_modal_bottom_sheet/light_modal_bottom_sheet.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  // with an empty paragraph
  final QuillEditorController controller = QuillEditorController();
  String title = 'Untitled';
  var selectedEmoji = "📌";
  bool expand = false;
  final json = jsonDecode(
      r"""[{"insert":"That's a lot of work and work and work and work and work and work and work and work and work and work and work and work and work and I can get a lot of work and work and work and work and work and work and work and work and work and work and work and work and work and work and work and work and work and work and work and work and work and work and work every day more and work more "},{"insert":"than it is more like it ","attributes":{"bold":true,"italic":true}},{"insert":"\n"}]""");
  final TextEditingController _editController = TextEditingController();

  void addData() async {
    await FirebaseFirestore.instance.collection('your_collection').add({
      'field1': 'value1',
      'field2': 'value2',
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_controller.document = Document.fromJson(json);
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "$selectedEmoji  $title",
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
        ),
        leading: IconButton(
          onPressed: () {
            // Navigator.of(context).pop();
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.black38,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        showMaterialModalBottomSheet(
                            expand: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (context) => StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setStatee) {
                                  return Column(
                                    children: [
                                      const Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.5,
                                          //color: Colors.white,

                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            //mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                                child: IconButton(
                                                  iconSize: 10,
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  onPressed: () {
                                                    //Get.back();
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    size: 25,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.8,
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(20),
                                                            topRight:
                                                                Radius.circular(
                                                                    20)),
                                                    color: Colors.white),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 5,
                                                      horizontal: 17),
                                                  //  padding: EdgeInsets.only(
                                                  //             bottom: MediaQuery.of(context).viewInsets.bottom),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "Emoji Picker",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      EmojiSelector(
                                                          columns: 4,
                                                          rows: 3,
                                                          onSelected: (v) {
                                                            setState(() {
                                                              selectedEmoji =
                                                                  v.char;
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: Text(
                          selectedEmoji,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 55,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  child: TextField(
                    controller: _editController,
                    onChanged: (v) {
                      if (_editController.text.trim() == '') {
                        setState(() {
                          title = "untitled";
                        });
                      } else {
                        setState(() {
                          title = _editController.text;
                        });
                      }
                    },
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: 'Untitled',
                      hintStyle: TextStyle(fontSize: 40, color: Colors.black12),

                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none, // Remove the underline border
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .transparent), // Color when the TextField is focused
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: QuillHtmlEditor(
                    text:
                        "<h1>Hello</h1>This is a quill html editor example 😊",
                    hintText: 'Hint text goes here',
                    controller: controller,
                    isEnabled: true,
                    minHeight: 300,
                    //textStyle: _editorTextStyle,
                    //hintTextStyle: _hintTextStyle,
                    hintTextAlign: TextAlign.start,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    hintTextPadding: EdgeInsets.zero,
                    //backgroundColor: _backgroundColor,
                    onFocusChanged: (hasFocus) =>
                        debugPrint('has focus $hasFocus'),
                    onTextChanged: (text) =>
                        debugPrint('widget text change $text'),
                    onEditorCreated: () => debugPrint('Editor has been loaded'),
                    onEditingComplete: (s) =>
                        debugPrint('Editing completed $s'),
                    onEditorResized: (height) =>
                        debugPrint('Editor resized $height'),
                    onSelectionChanged: (sel) =>
                        debugPrint('${sel.index},${sel.length}'),
                    loadingBuilder: (context) {
                      return const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 0.4,
                      ));
                    },
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
              ],
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            //     child: Container(
            //       padding: EdgeInsets.all(6),
            //       decoration: BoxDecoration(
            //           color: Colors.white,
            //           border: Border.all(color: Colors.black),
            //           borderRadius: BorderRadius.circular(20)),
            //       child: QuillToolbar(
            //         configurations: QuillToolbarConfigurations(
            //           //embedButtons: FlutterQuillEmbeds.toolbarButtons(),
            //           //controller: _controller,
            //           multiRowsDisplay: expand,
            //           showDividers: true,
            //           color: Colors.white,
            //           showBackgroundColorButton: true,
            //           toolbarIconAlignment: WrapAlignment.end,
            //           showInlineCode: false,
            //           toolbarSize: 40,
            //           showFontSize: true,
            //           showSmallButton: true,
            //           showDirection: true,
            //           showHeaderStyle: false,
            //           fontSizesValues: {
            //             'Heading 1': "30",
            //             'Heading 2': "24",
            //             'Heading 3': "18",
            //             'Heading 4': "16",
            //             'Heading 5': "14",
            //             'Heading 6': "12",
            //             'Normal': "15"
            //           },

            //           // buttonOptions: QuillSimpleToolbarButtonOptions(
            //           //     fontSize: QuillToolbarFontSizeButtonOptions(),
            //           //     backgroundColor: QuillToolbarColorButtonOptions(
            //           //         iconTheme: QuillIconTheme(
            //           //             iconButtonSelectedStyle:
            //           //                 ButtonStyle()))),
            //           showAlignmentButtons: true,
            //           // sharedConfigurations: const QuillSharedConfigurations(),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      )),
    );
  }
}
