# Foreman -> Overmind или от прораба к надмозгу

## Введение
Rails-приложения обычно состоят из нескольких процессов, например:

- web: сервер приложения rails
- workers: фоновые задачи (например, resque workers)
- scheduler: планировщик фоновых задач, (например, resque scheduler)
- assets: процесс для сборки frontend'a (например, webpack-dev-server)
- watcher: процесс, отслеживающий изменения проекта (например, guard для тестов)

Удобно запускать, останавливать, перезапускать эти процессы одной командой и в одном терминале.

Для этого часто используют [foreman](https://github.com/ddollar/foreman), но у него есть пара проблем.


## Что-то не так с foreman'ом
Foreman объединяет вывод всех управляемых процессов в единую кучy, в которой может искажаться цветной вывод процессов, теряться читаемость.

Но, самое главное, - нельзя взаимодействовать с отдельным процессом. А значит, **с Foreman невозможно дебажить**!


## Overmind решает вопросы
Overmind позволяет решить проблемы foreman.

Он использует [pty](https://en.wikipedia.org/wiki/Pseudoterminal) для перехвата и точного повторения вывода процессов.

Но, главное, он _запускает процессы в [tmux](https://tmux.github.io/) сессии_, даёт возможность подключаться и взаимодействовать с ними. **Ура, с Overmind можно дебажить.**

Получается так:
![overmind session screenshot](overmind_session_screenshot.png)

## Использование
### Готовим Procfile
Нужен такой же Procfile, как у Foreman или [Heroku](https://devcenter.heroku.com/articles/procfile)

Например:
```
  web: bin/rails server -p 3000
  workers: bundle exec resque-pool --environment development
  scheduler: bin/rake resque:scheduler
  assets: bin/webpack-dev-server --config config/webpack.config.js
  watcher: bundle exec guard
```

### Работаем с процессами
- **overmind s** - (start) запуск всех процессов
- **overmind c web** - подключение по tmux к процессу web для взаимодействия с ним
- **ctrl + b, d** - отключение от процесса tmux
- **overmind r web** - (restart) перезапуск одного из процессов
- **overmind k** - (kill) - остановка всех процессов

Лучше не делать вложенных tmux-сессий. То есть `overmind connect` нужно запускать из терминала, но не из tmux.

## Установка
Для работы потребуется установить tmux и сам overmind

### tmux
```
# on macOS (with homebrew)
$ brew install tmux
```
```
# on Ubuntu
$ apt-get install tmux
```
Для других операционных систем инструкции по установке можно поискать здесь: https://github.com/tmux/tmux

### overmind
Скачать [последний релиз](https://github.com/DarthSim/overmind/releases/latest) и положить в /usr/local/bin

Либо установить из исходников на Go: go get -u -f github.com/DarthSim/overmind


## Заключение
Overmind делает работу с Procfile удобной, приводит в порядок общий лог, позволяет подключаться к отдельным процессам и дебажить.

Если присоединяться к процессам нет необходимости, а аккуратный лог всё же хочется, то есть ещё [hivemind](https://github.com/DarthSim/hivemind).
