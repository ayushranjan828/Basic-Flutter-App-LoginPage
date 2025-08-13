import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../repositories/picsum_repository.dart';
import '../models/picsum_image.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PicsumRepository repo;
  bool loading = true;
  List<PicsumImage> images = [];
  String? error;

  @override
  void initState() {
    super.initState();
    repo = PicsumRepository();
    _load();
  }

  Future<void> _load() async {
    setState(()=> loading=true);
    try {
      final list = await repo.fetchImages(limit: 10);
      setState(()=> images = list);
    } catch (e) {
      setState(()=> error = e.toString());
    } finally {
      setState(()=> loading=false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final padding = screenW * 0.04;
    return Scaffold(
      appBar: AppBar(title: Text('Picsum Images')),
      body: RefreshIndicator(
        onRefresh: _load,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 12),
          child: loading ? Center(child: CircularProgressIndicator()) : error!=null ? Center(child: Text('Error: \$error')) : ListView.builder(
            itemCount: images.length,
            itemBuilder: (context, idx) {
              final img = images[idx];
              final height = screenW * (img.height / img.width);
              return Padding(
                padding: EdgeInsets.only(bottom:16.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  ClipRRect(borderRadius: BorderRadius.circular(12), child: CachedNetworkImage(
                    imageUrl: img.downloadUrl,
                    width: double.infinity,
                    height: height,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(height: height, child: Center(child: CircularProgressIndicator())),
                    errorWidget: (_, __, ___) => Container(height: height, color: Colors.grey[200], child: Icon(Icons.error)),
                  )),
                  SizedBox(height:8),
                  Text('Photo by \${img.author}', style: TextStyle(fontWeight: FontWeight.w600)),
                  SizedBox(height:4),
                  Text(img.url, maxLines:2, overflow: TextOverflow.ellipsis, style: TextStyle(color:Colors.grey[700])),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
