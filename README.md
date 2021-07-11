# Activerecord::Bitemporal::Tablize

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/activerecord/bitemporal/tablize`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord-bitemporal-tablize'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install activerecord-bitemporal-tablize

## Usage

1. ローカル環境でgemをインストールする
2. 以下を.pryrcなどに追加
  - インストールされたパスをロードパスに含める
  - requireする
```
# cat ~/.pryrc
$: << '/Users/lighty/.rbenv/versions/3.0.1/lib/ruby/gems/3.0.0/gems/activerecord-bitemporal-tablize-0.1.3/lib/'
require 'activerecord-bitemporal-tablize'
```


ref: https://qiita.com/kyanny/items/d370efe14ef15d9afacb

```
[1] pry(main)> Employee.first.histories.print_table
   (0.8ms)  SELECT sqlite_version(*)
  Employee Load (0.3ms)  SELECT "employees".* FROM "employees" WHERE "employees"."valid_from" <= ? AND "employees"."valid_to" > ? AND "employees"."deleted_at" IS NULL ORDER BY "employees"."bitemporal_id" ASC LIMIT ?  [["valid_from", "2021-06-20 13:21:42.229006"], ["valid_to", "2021-06-20 13:21:42.229006"], ["LIMIT", 1]]
  Employee Load (0.2ms)  SELECT "employees".* FROM "employees" WHERE "employees"."deleted_at" IS NULL AND "employees"."bitemporal_id" = ? ORDER BY "employees"."valid_from" DESC  [["bitemporal_id", 1]]
+------------+----+---------+--------+-----------+-------------------------+-------------------------+---------------+------------+------------+------------+-------------------------+-------------------------+
|            | id | unit_id | name   | joined_at | created_at              | updated_at              | bitemporal_id | valid_from | valid_to   | deleted_at | transaction_from        | transaction_to          |
+-9999/12/31-+----+---------+--------+-----------+-------------------------+-------------------------+---------------+------------+------------+------------+-------------------------+-------------------------+
|            | 1  | 2       | 山田   |           | 2021-06-20 01:44:43 UTC | 2021-06-20 01:44:43 UTC | 1             | 2021/04/01 | 9999/12/31 |            | 2021-06-20 01:44:43 UTC | 9999-12-31 00:00:00 UTC |
+-2021/04/01-+----+---------+--------+-----------+-------------------------+-------------------------+---------------+------------+------------+------------+-------------------------+-------------------------+
+-2021/04/01-+----+---------+--------+-----------+-------------------------+-------------------------+---------------+------------+------------+------------+-------------------------+-------------------------+
|            | 1  | 1       | たけし |           | 2021-06-20 01:44:43 UTC | 2021-06-20 01:44:43 UTC | 1             | 2020/01/01 | 2021/04/01 |            | 2021-06-20 01:44:43 UTC | 9999-12-31 00:00:00 UTC |
+-2020/01/01-+----+---------+--------+-----------+-------------------------+-------------------------+---------------+------------+------------+------------+-------------------------+-------------------------+
=> nil
[2] pry(main)> Employee.first.histories.print_table_diff_only
  Employee Load (0.2ms)  SELECT "employees".* FROM "employees" WHERE "employees"."valid_from" <= ? AND "employees"."valid_to" > ? AND "employees"."deleted_at" IS NULL ORDER BY "employees"."bitemporal_id" ASC LIMIT ?  [["valid_from", "2021-06-20 13:21:44.302316"], ["valid_to", "2021-06-20 13:21:44.302316"], ["LIMIT", 1]]
  Employee Load (0.1ms)  SELECT "employees".* FROM "employees" WHERE "employees"."deleted_at" IS NULL AND "employees"."bitemporal_id" = ? ORDER BY "employees"."valid_from" DESC  [["bitemporal_id", 1]]
+------------+---------+--------+-------------------------+------------+------------+
|            | unit_id | name   | updated_at              | valid_from | valid_to   |
+-9999/12/31-+---------+--------+-------------------------+------------+------------+
|            | 2       | 山田   | 2021-06-20 01:44:43 UTC | 2021/04/01 | 9999/12/31 |
+-2021/04/01-+---------+--------+-------------------------+------------+------------+
+-2021/04/01-+---------+--------+-------------------------+------------+------------+
|            | 1       | たけし | 2021-06-20 01:44:43 UTC | 2020/01/01 | 2021/04/01 |
+-2020/01/01-+---------+--------+-------------------------+------------+------------+
=> nil
[3] pry(main)> Employee.first.histories.print_table(:name)
  Employee Load (0.2ms)  SELECT "employees".* FROM "employees" WHERE "employees"."valid_from" <= ? AND "employees"."valid_to" > ? AND "employees"."deleted_at" IS NULL ORDER BY "employees"."bitemporal_id" ASC LIMIT ?  [["valid_from", "2021-06-20 13:22:54.269095"], ["valid_to", "2021-06-20 13:22:54.269095"], ["LIMIT", 1]]
  Employee Load (0.1ms)  SELECT "employees".* FROM "employees" WHERE "employees"."deleted_at" IS NULL AND "employees"."bitemporal_id" = ? ORDER BY "employees"."valid_from" DESC  [["bitemporal_id", 1]]
+------------+--------+
|            | name   |
+-9999/12/31-+--------+
|            | 山田   |
+-2021/04/01-+--------+
+-2021/04/01-+--------+
|            | たけし |
+-2020/01/01-+--------+
=> nil
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/activerecord-bitemporal-tablize.
