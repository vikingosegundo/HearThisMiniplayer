OFAPopulator
============

*Once and For All TableView and CollectionView Populator*

Using the Adapter Pattern the goal of OFA is to make the hassle of populating table and collection views go away and get easy to subclass and reusable components. Without harming MVC or limit the delegate/datasource pattern

Populating a tableview with one section:

```objc
OFASectionPopulator *section1Populator = [[OFASectionPopulator alloc] initWithParentView:self.tableView
                                                                             dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                               cellClass:[UITableViewCell class]
                                                                          cellIdentifier:^NSString* (id obj, NSIndexPath *indexPath){ return  indexPath.row % 2  ? @"Section1_1" : @"Section1_2" ; }
                                                                        cellConfigurator:^(id obj, UIView *view, NSIndexPath *indexPath)
{
    UITableViewCell *cell = (UITableViewCell *)view;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", obj];
    cell.textLabel.backgroundColor = [UIColor clearColor];
}];
self.populator = [[OFASectionedPopulator alloc] initWithParentView:self.tableView
                                                 sectionPopulators:@[section1Populator]];

```

Populating a collection view with one section and the same data:

```objc
OFASectionPopulator *section1Populator = [[OFASectionPopulator alloc] initWithParentView:self.collectionView
                                                                             dataFetcher:[[ExampleDataFetcher alloc] init]
                                                                               cellClass:[ExampleCollectionViewCell class]
                                                                          cellIdentifier:^NSString* (id obj, NSIndexPath *indexPath){ return  indexPath.row % 2  ? @"cell" : @"cell2" ; }
                                                                        cellConfigurator:^(id obj, UIView *view, NSIndexPath *indexPath)
{
    ExampleCollectionViewCell *cell = (ExampleCollectionViewCell *)view;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", obj];
}];


self.populator = [[OFASectionedPopulator alloc] initWithSectionPopulators:@[section1Populator]];
```

Except passing in a collection view and a UICollectionViewCell class, the codes are identical.

![tableview](https://github.com/vikingosegundo/ofapopulator/raw/master/tableview.png) ![collectionview](https://github.com/vikingosegundo/ofapopulator/raw/master/collectionview.png)


Swift Example

```Swift


self.activityDataProvider = ActivityDataProvider(activities:activities)
let cellIdentifier = { (activity: AnyObject!, indexPath:NSIndexPath!) -> String! in
    let s : String! = "ActivityCell"
    return s
}

let cellConfigurator = { (obj :AnyObject!, cell: AnyObject!, indexPath:NSIndexPath!) -> Void in
    if let theCell = cell as? ActivityTableCell, activity = obj as? Activity,c = self.activityCellConfigurator{
        c(obj: activity, cell: theCell, indexPath: indexPath)
    }
}

let activitySectionPopulator = OFASectionPopulator(
    parentView: self.tableView,
    dataProvider: activityDataProvider as! OFADataProvider!,
    cellIdentifier: cellIdentifier,
    cellConfigurator:cellConfigurator
)

activitySectionPopulator.objectOnCellSelected = {[unowned self](obj :AnyObject!, cell: UIView!, indexPath:NSIndexPath!) -> Void in
    if let theCell = cell as? ActivityTableCell, activity = obj as? Activity, c = self.activitySelectedOnCell{
        c(obj: activity, cell: theCell, indexPath: indexPath)
    }
    if let activityCell = cell as? UITableViewCell{
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

activitySectionPopulator.heightForCellAtIndexPath = {[unowned self](obj: AnyObject!, indexPath:NSIndexPath!) -> CGFloat in
    return ActivityTableCell.heightForActivity(self.activities[indexPath.row], width: self.tableView.frame.size.width)
}


self.activityTableViewPopulator = OFAViewPopulator(sectionPopulators: [activitySectionPopulator])
self.activityTableViewPopulator!.didScroll = {(scrollView:UIScrollView!) -> Void in
    let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height
    if (endScrolling >= scrollView.contentSize.height - 400) {
        self.loadMore()
    }
}


```


## Install

* via Cocoapods:

        pod 'OFAPopulator'
