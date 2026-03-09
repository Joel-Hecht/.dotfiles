use std::cmp;

#[derive(Debug)]
enum MainErr {
    Bad,
    Worse,
    Worst,
}

fn main() -> Result<(), MainErr> {
    let one = 1;
    let two = 2;

    println!("{:?} is greater than {:?}",
        cmp::max(one, two), cmp::min(one, two));

    match two {
        2.. => Ok(()),
        i if i == one => Err(MainErr::Bad),
        i if i == two => Err(MainErr::Worse),
        _ => Err(MainErr::Worst),
    }
}
