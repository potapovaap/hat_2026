import UIKit
extension sectionsVC {
//############	CollectionView Delegate functions	###############################
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
		case 2:         return groupFieldSections.count
		case 4:         return sortFieldSections.count

        default: return 0
        }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch collectionView.tag {
		case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCollectionViewCell", for: indexPath) as? GroupCollectionViewCell else { return UICollectionViewCell() }
            let groupfieldsection = groupFieldSections[indexPath.item]
			let cellSelected = (selectedGroupFieldSectionIndex == indexPath.item)
			cell.backView.backgroundColor = cellSelected ? UIColor(hex: "40AF4B") : UIColor(hex: "ffffff").withAlphaComponent(0.2)
			cell.bottomView.backgroundColor = .clear
            cell.groupFieldLabel.text = title(groupfieldsection).uppercased()
			cell.backgroundColor = .clear
			cell.contentView.backgroundColor = .clear


            return cell
		case 4:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SortCollectionViewCell", for: indexPath) as? SortCollectionViewCell else { return UICollectionViewCell() }
            let sortfieldsection = sortFieldSections[indexPath.item]
			let cellSelected = (selectedSortFieldSectionIndex == indexPath.item)
			cell.backView.backgroundColor = cellSelected ? appMainColor : .clear
			cell.sortFieldLabel.text = title(sortfieldsection)
			cell.sortFieldLabel.textColor = cellSelected ? UIColor(hex: "FFFFFF") : UIColor(hex: "FFFFFF")
			cell.backgroundColor = .clear
			cell.contentView.backgroundColor = .clear


            return cell

        default: return UICollectionViewCell()
        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch collectionView.tag {
		case 2:
            let width = collectionView.frame.size.width
            let height = collectionView.frame.size.height
            let horizontalSpacing = CGFloat(0)
            let verticalSpacing = CGFloat(0)
            let rowsCount = CGFloat(1)
            let columnsCount = CGFloat(4)
            let cellWidth = (width - horizontalSpacing * (columnsCount - 1)) / columnsCount
            let cellHeight = (height - verticalSpacing * (rowsCount - 1)) / rowsCount
            return CGSize(width: cellWidth, height: cellHeight)
		case 4:
            let width = collectionView.frame.size.width
            let height = collectionView.frame.size.height
            let horizontalSpacing = CGFloat(0)
            let verticalSpacing = CGFloat(0)
            let rowsCount = CGFloat(1)
            let columnsCount = CGFloat(3)
            let cellWidth = (width - horizontalSpacing * (columnsCount - 1)) / columnsCount
            let cellHeight = (height - verticalSpacing * (rowsCount - 1)) / rowsCount
            return CGSize(width: cellWidth, height: cellHeight)

        default: return CGSize(width: 0, height: 0)
        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag {
		case 2:         return 0
		case 4:         return 0

        default: return 0
        }

    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag {
		case 2:         return 0
		case 4:         return 0

        default: return 0
        }

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        switch collectionView.tag {
		case 2:
            let width = collectionView.frame.size.width
            let height = collectionView.frame.size.height
            let horizontalSpacing = CGFloat(0)
            let verticalSpacing = CGFloat(0)
            let rowsCount = CGFloat(1)
            let columnsCount = CGFloat(4)
            let cellWidth = (width - horizontalSpacing * (columnsCount - 1)) / columnsCount
            let cellHeight = (height - verticalSpacing * (rowsCount - 1)) / rowsCount
            let totalCellWidth = cellWidth * columnsCount
            let totalHorizontalSpacing = horizontalSpacing * (columnsCount - 1)
            let totalCellHeight = cellHeight * rowsCount
            let totalVerticalSpacing = verticalSpacing * (rowsCount - 1)
            let topInset = CGFloat(0)
            let bottomInset = CGFloat(0)
            let leftInset = CGFloat(0)
            let rightInset = CGFloat(0)
            return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
		case 4:
            let width = collectionView.frame.size.width
            let height = collectionView.frame.size.height
            let horizontalSpacing = CGFloat(0)
            let verticalSpacing = CGFloat(0)
            let rowsCount = CGFloat(1)
            let columnsCount = CGFloat(3)
            let cellWidth = (width - horizontalSpacing * (columnsCount - 1)) / columnsCount
            let cellHeight = (height - verticalSpacing * (rowsCount - 1)) / rowsCount
            let totalCellWidth = cellWidth * columnsCount
            let totalHorizontalSpacing = horizontalSpacing * (columnsCount - 1)
            let totalCellHeight = cellHeight * rowsCount
            let totalVerticalSpacing = verticalSpacing * (rowsCount - 1)
            let topInset = CGFloat(0)
            let bottomInset = CGFloat(0)
            let leftInset = CGFloat(0)
            let rightInset = CGFloat(0)
            return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)

        default: return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch collectionView.tag {
		case 2:
			selectedGroupFieldSectionIndex = indexPath.item
			userDefaults.set(selectedGroupFieldSectionIndex, forKey: "selectedGroupFieldSectionIndex")
			updateSections()
			collectionView.reloadData()
		case 4:
			selectedSortFieldSectionIndex = indexPath.item
			userDefaults.set(selectedSortFieldSectionIndex, forKey: "selectedSortFieldSectionIndex")
			updateSections()
			collectionView.reloadData()

        default: break
        }

    }



//############	End CollectionView Delegate functions	############################


}
