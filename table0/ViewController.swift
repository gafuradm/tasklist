import UIKit
import SnapKit

class ViewController: UIViewController {
    var task: TaskComposite?
    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    init(task: TaskComposite) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        makeConstraints()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        task?.children.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = task?.children[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subTask = task?.children[indexPath.row]
        let viewContoller = ViewController(task: subTask!)
        navigationController?.pushViewController(viewContoller, animated: true)
    }
}

private extension ViewController {
    func setupScene() {
        title = task?.name
        tableView.delegate = self
        tableView.dataSource = self
        let addButton = UIBarButtonItem(title: "Add Task",
                                        style: .plain,
                                        target: self,
                                        action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        view.addSubview(tableView)
    }

    func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Add Task",
                                                message: nil,
                                                preferredStyle: .alert)

        alertController.addTextField()

        let addAction = UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
            if let text = (alertController.textFields?[0] as? UITextField)?.text {
                let newSubtask = Task(name: text)
                self.task?.addChild(newSubtask)
                self.tableView.reloadData()
            }
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}

protocol TaskComposite: class {
    var parent: TaskComposite? { get set }
    var children: [TaskComposite] { get set }
    var name: String { get set }

    func addChild(_ child: TaskComposite)
}

extension TaskComposite {
    func addChild(_ child: TaskComposite) {
        child.parent = self
        children.append(child)
    }
}

class Task: TaskComposite {
    weak var parent: TaskComposite?
    var children: [TaskComposite] = []
    var name: String

    init(name: String) {
        self.name = name
    }
}

class SubtaskViewController: UIViewController {
    var task: TaskComposite?
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var parentName: TaskComposite? {
        get {
            return task?.parent
        }
        set {
            task?.parent = newValue
        }
    }

    var childrenName: [TaskComposite] {
        get {
            return task?.children ?? []
        }
        set {
            task?.children = newValue
        }
    }

    var name: String {
        get {
            return task?.name ?? ""
        }
        set {
            task?.name = newValue
        }
    }
    var nameT: String {
        get {
            return task?.name ?? ""
        }
        set {
            task?.name = newValue
        }
    }
    init(task: TaskComposite) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
        makeConstraints()
    }
}

extension SubtaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        task?.children.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = task?.children[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subTask = task?.children[indexPath.row]
        let viewContoller = SubtaskViewController(task: subTask!)
        navigationController?.pushViewController(viewContoller, animated: true)
    }
}

private extension SubtaskViewController {
    func setupScene() {
        title = task?.name
        tableView.delegate = self
        tableView.dataSource = self
        let addButton = UIBarButtonItem(title: "Add Task",
                                        style: .plain,
                                        target: self,
                                        action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        view.addSubview(tableView)
    }

    func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Add Task",
                                                message: nil,
                                                preferredStyle: .alert)

        alertController.addTextField()

        let addAction = UIAlertAction(title: "Add", style: .default, handler: { (action) -> Void in
            if let text = (alertController.textFields?[0] as? UITextField)?.text {
                let newSubtask = Task(name: text)
                self.task?.addChild(newSubtask)
                self.tableView.reloadData()
            }
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alertController.addAction(addAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true)
    }
}
