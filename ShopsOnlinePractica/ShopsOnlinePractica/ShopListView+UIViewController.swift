import UIKit

extension ShopListViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopListCell", for: indexPath) as! ShopListCell
        
        cell.coreShop = self.fetchedResultsController.object(at: indexPath)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print ("Seleccionada fila:" + indexPath.row.description)
        
        let shop = self.fetchedResultsController.object(at: indexPath)
        
        shopName = shop.name!
        desc = shop.description_es!
        address = shop.address!
        mapHash = shop.mapImageHash!
        
        print("Nombre: " + shop.name!)
        print("Descripcion: " + shop.description_es!)
        print("Address: " + shop.address!)
        print("Mapa: " + shop.mapImageHash!.description)
        
        self.performSegue(withIdentifier: "shopDetail", sender: self)
    }
    
}

