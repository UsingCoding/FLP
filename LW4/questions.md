### Вопросы к функциям в модуле

1. Что будет результатом выполнения функции

LWModule.deleteAt 2 Map.insert 2 "qwerty" $ Map.insert 2 "123" $ Map.singleton 1 "1"

1. - Map.fromList [(1, "1")]
2. - Map.fromList [(1, "1"), (2, "123")]
3. - error


2. Что будет результатом выполнения функции

let specialSet = Set.fromList [x | x <- [1..10], mod x 2 /= 0]

LWModule.filter odd specialSet

1. - Set.fromList [2,4,6,8,10]
2. - Set.fromList [1,3,5,7,9]
3. - error
4. - Set.fromList []
