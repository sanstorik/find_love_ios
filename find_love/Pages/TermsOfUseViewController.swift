import UIKit

class TermsOfUseViewController: CommonViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(title: "Cоглашение")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _textView.flashScrollIndicators()
    }
    
    override func viewDidLayoutSubviews() {
        _textView.setContentOffset(.zero, animated: false)
    }
    
    private let _textView: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.text = """
        1. ОБЩИЕ ПОЛОЖЕНИЯ
        
        1.1. Настоящее Пользовательское соглашение (далее – Соглашение) относится к сайту Интернет-магазина «название интернет-магазина», расположенному по адресу www.адрес интернет-магазина, и ко всем соответствующим сайтам, связанным с сайтом адрес интернет-магазина.
        
        1.2.    Сайт Интернет-магазина «название интернет-магазина» (далее – Сайт) является собственностью название организации, предприятия
        
        1.3.    Настоящее Соглашение регулирует отношения между Администрацией сайта Интернет-магазина « название интернет-магазина»(далее – Администрация сайта) и Пользователем данного Сайта.
        
        1.4. Администрация сайта оставляет за собой право в любое время изменять, добавлять или удалять пункты настоящего Соглашения без уведомления Пользователя.
        
        1.5. Продолжение использования Сайта Пользователем означает принятие Соглашения и изменений, внесенных в настоящее Соглашение.
        
        1.6. Пользователь несет персональную ответственность за проверку настоящего Соглашения на наличие изменений в нем.
        
        
        2. ОПРЕДЕЛЕНИЯ ТЕРМИНОВ
        
        2.1. Перечисленные ниже термины имеют для целей настоящего Соглашения следующее значение:
        2.1.1 «название интернет-магазина» – Интернет-магазин, расположенный на доменном имени www.адрес интернет-магазина, осуществляющий свою деятельность посредством Интернет-ресурса и сопутствующих ему сервисов.
        
        2.1.2. Интернет-магазин – сайт, содержащий информацию о Товарах, Продавце, позволяющий осуществить выбор, заказ и (или) приобретение Товара.
        
        2.1.3. Администрация сайта Интернет-магазина – уполномоченные сотрудники на управления Сайтом, действующие от имени название организации.
        
        2.1.4. Пользователь сайта Интернет-магазина (далее ? Пользователь) – лицо, имеющее доступ к Сайту, посредством сети Интернет и использующее Сайт.
        
        2.1.5. Содержание сайта Интернет-магазина (далее – Содержание) - охраняемые результаты интеллектуальной деятельности, включая тексты литературных произведений, их названия, предисловия, аннотации, статьи, иллюстрации, обложки, музыкальные произведения с текстом или без текста, графические, текстовые, фотографические, производные, составные и иные произведения, пользовательские интерфейсы, визуальные интерфейсы, названия товарных знаков, логотипы, программы для ЭВМ, базы данных, а также дизайн, структура, выбор, координация, внешний вид, общий стиль и расположение данного Содержания, входящего в состав Сайта и другие объекты интеллектуальной собственности все вместе и/или по отдельности, содержащиеся на сайте Интернет-магазина.
        """
        
        view.font = UIFont.systemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor.white
        view.backgroundColor = UIColor.black
        view.indicatorStyle = UIScrollViewIndicatorStyle.white
        
        return view
    }()
    
    private func setupViews() {
        _textView.font = _textView.font?.withHeightConstant(multiplier: 0.03, view: view)
        view.addSubview(_textView)
        
        _textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        _textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        _textView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 25).isActive = true
        _textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    }
}
