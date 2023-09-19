function newAccount (initialBalance)
    local self = {balance = initialBalance}

    local withdraw = function (v) self.balance = self.balance - v end

    local deposit = function (v) self.balance = self.balance + v end

    local getBalance = function () return self.balance end

    return {
        withdraw = withdraw,
        deposit = deposit,
        getBalance = getBalance,
    }
end

acc1 = newAccount(100.00)
acc1.withdraw(40.00)
print(acc1.getBalance()) --> 60