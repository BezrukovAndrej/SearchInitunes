
## **Search in itunes**
Приложение о поиске музыкальных альбомов, артиста, группы.
## **Скриншот**
<a href="https://ibb.co/rdQBb3P"><img src="https://i.ibb.co/3RTxfvX/iTunes.png" alt="iTunes" border="0"></a>
## **Функциональность**
- При запуске приложения показывается сплеш-скрин.
- После запуска приложения показывается экран входа.
- При нажатии кнопки SingUP открывается экран регистрации.
  - На экране регистрации нужно ввести:
    - Имя
    - Фамилию
    - Дату рождения ( вам должно быть больше 18 лет )
    - Номер телефона
    - Почту
    - Пароль
  - В случай не корректного заполнения под TextFild появляется уведомление где не корректно заполнено.
  - Если поля не заполнены, появляется Alert.
  - После успешной регистрации появляется уведомление об успешной регистрации.
- При нажатии на SingIN (если вы зарегистрированы) открывается поисковик, в противном случай появляется уведомление "User not found".
- В поисковике вбиваете любой альбом, группу, артиста.
  - В случай не корректного ввода текста в поисковик появляется Alert.
- При нажатие на выбранный альбом открывается дополнительно окно с описанием:
  - Лого альбома
  - Название альбома 
  - Название артиста
  - Год выпуска
  - Количество треков
  - Название треков
- При нажатии на личный кабинет "Active User" отображаются личный данный при регистрации (кроме пароля) 

## **Использовалось**
- No storyboard, 100% Programmatic UI
- Scene Delegate
- Custom Alerts
- SFSymbols
- [API](https://performance-partners.apple.com/search-api)
- Asynchronous Network Calls, NSURLSession, Codable

## **Технические требования**

- Приложение поддерживает устройства iPhone с iOS 13, предусмотрен только портретный режим.
- Элементы интерфейса адаптируются под разные разрешения экранов, начиная с iPhone X.


## **Search in itunes**
Application about finding music albums, artist, group.

## **Functionality**
- When the application starts, a splash screen is shown.
- After launching the application, the login screen is shown.
- Pressing the SingUp button opens the registration screen.
   - On the registration screen you need to enter:
     - Name
     - Surname
     - Date of birth (you must be over 18 years old)
     - Phone number
     - Mail
     - Password
   - In case of incorrect filling, a notification appears under TextFild where it is not correctly filled.
   - If the fields are not filled, an Alert appears.
   - After successful registration, a notification of successful registration appears.
- Clicking on SingIN (if you are registered) opens a search engine, otherwise a notification "User not found" appears.
- In the search engine, drive in any album, group, artist.
  - In case of incorrect text entry into the search engine, an Alert appears.
- When you click on the selected album, an additional window opens with a description:
   - Album logo
   - Album name
   - Artist name
   - Year of issue
   - Number of tracks
   - Track titles
- When you click on the "Active User" personal account, personal data is displayed during registration (except for the password)

## **Used**
- No storyboard, 100% Programmatic UI
-Scene Delegate
- Custom Alerts
- SFSymbols
- [API](https://performance-partners.apple.com/search-api)
- Asynchronous Network Calls, NSURLSession, Codable

## **Technical requirements**

- The application supports iPhone devices with iOS 13, only portrait mode is provided.
- Interface elements adapt to different screen resolutions, starting with iPhone X.
