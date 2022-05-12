// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../models/audio_model.dart';
// import '../../repositories/audio_repositories.dart';
//
// abstract class ItemRepository {
//   Stream<List<AudioModel>> getItems({
//     String startAfterId = '',
//     int paginationSize = 10,
//   });
// }
//
// class FirebaseItemRepository implements ItemRepository {
//   final AudioRepositories repositories = AudioRepositories();
//
//   @override
//   Stream<List<AudioModel>> getItems({
//     String startAfterId = '',
//     int paginationSize = 10,
//   }) {
//     return FirebaseFirestore.instance
//         .collection(repositories.user!.phoneNumber!)
//         .doc('id')
//         .collection('Collections')
//         .startAfter([startAfterId])
//         .limit(paginationSize)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => AudioModel.fromJson(doc.data()))
//             .toList());
//   }
// }
// ////////////////////////////////////////////////////
// BlocProvider(
// create: (_) => ListBloc(FirebaseItemRepository())..add(LoadItems()),
// // BlocProvider<AnimBloc>(
// //   create: (context) => AnimBloc(),
// )
// ],
//
//
//
// ////////////////////////////////////////////////////
// import '../../../../models/audio_model.dart';
//
// enum ListStatus { initial, loading, success, failure }
//
// @immutable
// class ListState {
//   const ListState({
//     this.status = ListStatus.initial,
//     this.itemsPages = const [],
//     this.hasMoreData = true,
//   });
//   final ListStatus status;
//   final List<List<AudioModel>> itemsPages;
//   final bool hasMoreData;
//
//   List<AudioModel> get items => itemsPages.expand((e) => e).toList();
//
//   ListState copyWith({
//     ListStatus? status,
//     List<List<AudioModel>>? itemsPages,
//     bool? hasMoreData,
//   }) {
//     return ListState(
//       status: status ?? this.status,
//       itemsPages: itemsPages ?? this.itemsPages,
//       hasMoreData: hasMoreData ?? this.hasMoreData,
//     );
//   }
// }
//
//
//
// //////////////////////////////////////////////////////
//
// import 'dart:async';
// import 'package:rxdart/rxdart.dart';
// import 'package:blocs/blocs.dart';
//
// import '../../firebase_item_repository.dart';
// import 'audio_recordings_list_event.dart';
// import 'audio_recordings_list_state.dart';
//
// const PAGINATION_SIZE = 10;
//
// // const throttleDuration = Duration(milliseconds: 500);
// // EventTransformer<E> throttleDroppable<E>(
// //   Duration duration,
// // ) {
// //   return (events, mapper) {
// //     return droppable<E>().call(events.debounceTime(duration), mapper);
// //   };
// // }
//
// class ListBloc extends Bloc<ListEvent, ListState> {
//   final ItemRepository _repository;
//   final List<StreamSubscription> _itemsSubscriptions = [];
//
//   ListBloc(this._repository) : super(const ListState()) {
//     on<LoadItems>((event, emit) => _mapLoadItems(event, emit));
//     on<LoadNextItemsPage>(
//           (event, emit) => _mapLoadNextItemsPage(event, emit),
//       // transformer: throttleDroppable(throttleDuration),
//     );
//     on<PageUpdated>((event, emit) => _mapPageUpdated(event, emit));
//     on<FailureEvent>((event, emit) => _mapFailureEvent(event, emit));
//   }
//
//   @override
//   Future<void> close() {
//     _itemsSubscriptions.forEach((souscription) => souscription.cancel());
//     return super.close();
//   }
//
//   // this is the mapping of the initial LoadItems event
//   void _mapLoadItems(LoadItems event, Emitter emit) {
//     // let's notify that we are starting to load something
//     emit(
//       state.copyWith(
//         status: ListStatus.loading,
//         itemsPages: const [],
//         hasMoreData: true,
//       ),
//     );
//
//     _itemsSubscriptions.forEach((souscription) => souscription.cancel());
//     _itemsSubscriptions.clear();
//     // then we add a new subscription for the first page
//     _itemsSubscriptions.add(
//       _repository.getItems(paginationSize: PAGINATION_SIZE).listen(
//             (page) {
//           add(PageUpdated(pageNumber: 0, newPage: page));
//         },
//         onError: (error) {
//           add(FailureEvent());
//         },
//       ),
//     );
//   }
//
//   void _mapLoadNextItemsPage(LoadNextItemsPage event, Emitter emit) {
//     if (state.hasMoreData) {
//       final newPageNumber = state.items.length;
//       final lastItem = state.items.last;
//
//       _itemsSubscriptions.add(
//         _repository
//             .getItems(
//             startAfterId: lastItem.id!, paginationSize: PAGINATION_SIZE)
//             .listen(
//               (page) {
//             add(PageUpdated(newPage: page, pageNumber: newPageNumber));
//           },
//           onError: (error) {
//             add(FailureEvent());
//           },
//         ),
//       );
//     }
//   }
//
//   void _mapPageUpdated(PageUpdated event, Emitter emit) {
//     final newPage = event.newPage;
//     final pageNumber = event.pageNumber;
//     var itemsPages = List.of(state.itemsPages);
//     var hasMoreData = state.hasMoreData;
//
//     bool reset = false;
//
//     if (itemsPages.length <= pageNumber) {
//       itemsPages.add(newPage);
//       hasMoreData = newPage.length == PAGINATION_SIZE;
//     } else if (pageNumber == itemsPages.length - 1 && newPage.isNotEmpty) {
//       hasMoreData = newPage.length == PAGINATION_SIZE;
//       itemsPages[pageNumber].clear();
//       itemsPages[pageNumber] = newPage;
//     } else if (newPage.length == itemsPages[pageNumber].length &&
//         newPage.map((e) => e.id).every(
//               (e) => itemsPages[pageNumber].map((e) => e.id).contains(e),
//         )) {
//       itemsPages[pageNumber].clear();
//       itemsPages[pageNumber] = newPage;
//     } else {
//       reset = true;
//     }
//
//     // either we reset the list
//     if (reset) {
//       add(LoadItems());
//     } else {
//       emit(
//         state.copyWith(
//           status: ListStatus.success,
//           itemsPages: itemsPages,
//           hasMoreData: hasMoreData,
//         ),
//       );
//     }
//   }
//
//   void _mapFailureEvent(FailureEvent event, Emitter emit) {
//     emit(
//       state.copyWith(
//         status: ListStatus.failure,
//       ),
//     );
//   }
// }
// //////////////////////////////////////////////////////////////////////
//
//
//
// class ListPlayer extends StatefulWidget {
//   ListPlayer({Key? key}) : super(key: key);
//
//   @override
//   State<ListPlayer> createState() => _ListPlayerState();
// }
//
// class _ListPlayerState extends State<ListPlayer> {
//   final AudioRepositories repositories = AudioRepositories();
//   //the scroll controller will tell us when we are reaching the bottom
//   //once the treshold is triggered, we will send an event to our bloC to fetch a new page
//   final _scrollController = ScrollController();
//   final _scrollThreshold = 0.95;
//   late final ListBloc _itemsBloc;
//
//   void _onScroll() {
//     //if the bottom of the list is reached, request a new page
//     if (_isBottom) _itemsBloc.add(LoadNextItemsPage());
//   }
//
//   //check when we have reached the bottom
//   bool get _isBottom {
//     if (!_scrollController.hasClients) return false;
//     final maxScroll = _scrollController.position.maxScrollExtent;
//     final currentScroll = _scrollController.offset;
//     return currentScroll >= (maxScroll * _scrollThreshold);
//   }
//
//   //the initState will allow us to add our scroll listener and initialize the BloC
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     _itemsBloc = BlocProvider.of<ListBloc>(context);
//   }
//
//   //do not forget to clean after us
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight = MediaQuery.of(context).size.height;
//     return SizedBox(
//       height: screenHeight,
//       child: BlocBuilder<ListBloc, ListState>(builder: (context, state) {
//         if (state.status == ListStatus.initial)
//           return Center(child: CircularProgressIndicator());
//         // in case of failure
//         if (state.status == ListStatus.failure)
//           return Center(child: Text('Ouch: There was an error!'));
//         // if the list is loading and the list is empty (first page)
//         if (state.status == ListStatus.loading && state.items.isEmpty)
//           return Center(child: CircularProgressIndicator());
//         // if the status is success but the list is empty (no items i)
//         if (state.status == ListStatus.success && state.items.isEmpty)
//           return Center(child: Text('The list is empty!'));
//         return ListView.builder(
//           // if the list has more items to load, add one position for the bottom loader
//           itemCount:
//           state.hasMoreData ? state.items.length + 1 : state.items.length,
//           controller: _scrollController,
//           itemBuilder: (BuildContext context, int index) {
//             final audio = state.items[index];
//             //hence we show the loader if index exceed the list length
//             return index >= state.items.length
//                 ? CircularProgressIndicator()
//                 : PlayerMini(
//               playPause: audio.playPause,
//               duration: '${audio.duration}',
//               url: '${audio.audioUrl}',
//               name: '${audio.audioName}',
//               done: audio.done!,
//               id: '${audio.id}',
//               collection: audio.collections ?? [],
//               popupMenu: PopupMenuAudioRecording(
//                 url: '${audio.audioUrl}',
//                 duration: '${audio.duration}',
//                 name: '${audio.audioName}',
//                 dateTime: audio.dateTime!,
//                 done: audio.done!,
//                 searchName: audio.searchName!,
//                 idAudio: '${audio.id}',
//                 collection: audio.collections!,
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
// ////////////////////////////////////////////////////
