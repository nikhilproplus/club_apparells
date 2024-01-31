import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_api/controller/controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetDataController getDataController = Get.put(GetDataController());
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    getDataController.getDataApi();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Club Apparels",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.purple.shade700,
          elevation: 3,
          shadowColor: Colors.grey,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await getDataController.getDataApi();
          },
          backgroundColor: Colors.purple,
          child: const Icon(Icons.refresh),
        ),
        backgroundColor: Colors.purple.shade200,
        body: Center(
          child: SmartRefresher(
            enablePullDown: true,
            // enablePullUp: true,
            onRefresh: () {
              getDataController.saveData.clear();
              getDataController.getDataApi();
              refreshController.refreshCompleted();
            },
            onLoading: () {
              getDataController.getDataApi();
              refreshController.loadComplete();
            },
            controller: refreshController,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: getDataController.searchItemController.value,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        isDense: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        filled: true,
                        fillColor: Colors.purple.shade100,
                        hintText: 'adiddas',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              getDataController.itemName.value =
                                  getDataController
                                      .searchItemController.value.text;
                              getDataController.saveData.clear();
                              await getDataController.getDataApi();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Search'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        getDataController.itemName.value = 'adiddas';
                        getDataController.searchItemController.value.clear();
                        getDataController.saveData.clear();
                        await getDataController.getDataApi();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Clear Screen'),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Items by  ${getDataController.itemName.value}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => getDataController.isDataLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : getDataController.saveData.first!.hits.isEmpty
                              ? const Text(
                                  "No items available, please check your spelling",
                                  style: TextStyle(color: Colors.white),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: getDataController
                                      .saveData.first!.hits.length,
                                  itemBuilder: (context, index) {
                                    var apiData = getDataController
                                        .saveData.first!.hits[index];

                                    return Card(
                                      elevation: 4,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          // Add your item click action here
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (apiData.image.isNotEmpty)
                                              ClipRRect(
                                                borderRadius: const BorderRadius
                                                    .vertical(
                                                    top: Radius.circular(15)),
                                                child: Image.network(
                                                  apiData.image,
                                                  height: 200,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    apiData.title,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    '\$${apiData.basePrice.toString()}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.purple,
                                                    ),
                                                  ),
                                                  Text(apiData.category
                                                      .toString()),
                                                  Text(
                                                    apiData.description
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
