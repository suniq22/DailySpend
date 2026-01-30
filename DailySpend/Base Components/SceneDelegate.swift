import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let settingsStore = SettingsStore()
        let expenseStore = ExpenseStore(settingsStore: settingsStore)
        expenseStore.load()
        
        let mainVC = MainViewController(expenseStore: expenseStore, settingsStore: settingsStore)
        let mainNav = UINavigationController(rootViewController: mainVC)
        mainNav.tabBarItem = UITabBarItem(
            title: "Today's total",
            image:UIImage(systemName: "dollarsign.bank.building") ,
            selectedImage: UIImage(systemName: "dollarsign.bank.building.fill")
        )

        let historyVC = HistoryViewController(expenseStore: expenseStore)
        let historyNav = UINavigationController(rootViewController: historyVC)
        historyNav.tabBarItem = UITabBarItem(
            title: "History",
            image: UIImage(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90"),
            selectedImage: UIImage(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
        )
        
        let statisticsVC = StatisticsViewController(expenseStore: expenseStore, settingsStore: settingsStore)
        let statisticsNav = UINavigationController(rootViewController: statisticsVC)
        statisticsNav.tabBarItem = UITabBarItem(
            title: "Statistics",
            image: UIImage(systemName: "chart.bar"),
            selectedImage: UIImage(systemName: "chart.bar.fill")
        )
        
        let settingsVC = SettingsViewController(settingsStore: settingsStore)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        settingsNav.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        
        let tabBar = UITabBarController()
        tabBar.viewControllers = [mainNav, historyNav,statisticsNav, settingsNav]

        window.rootViewController = tabBar
        self.window = window
        window.makeKeyAndVisible()
    }

}

