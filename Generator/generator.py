import math
import random

class Board:

    SIZE = 9
    BLOCK_SIZE = int(math.sqrt(SIZE))

    def __init__(self):
        self.board = []
        for _ in range(Board.SIZE):
            self.board.append([0] * Board.SIZE)
        self.complete = False

    def have_duplicate_in_row(self, row, col):
        for c in range(Board.SIZE):
            if c!=col and self.board[row][c]!=0:
                if self.board[row][col]==self.board[row][c]:
                    return True
        return False

    def have_duplicate_in_column(self, row, col):
        for r in range(Board.SIZE):
            if r!=row and self.board[r][col]!=0:
                if self.board[row][col]==self.board[r][col]:
                    return True
        return False

    def have_duplicate_in_block(self, row, col):
        block_row = int(row//Board.BLOCK_SIZE) * Board.BLOCK_SIZE
        block_col = int(col//Board.BLOCK_SIZE) * Board.BLOCK_SIZE
        for r in range(block_row, block_row+Board.BLOCK_SIZE):
            for c in range(block_col, block_col+Board.BLOCK_SIZE):
                if (r!=row or c!=col) and self.board[r][c]!=0:
                    if self.board[row][col]==self.board[r][c]:
                        return True
        return False

    def have_duplicate(self, row, col):
        return (self.have_duplicate_in_row(row, col) 
                or self.have_duplicate_in_column(row, col) 
                or self.have_duplicate_in_block(row, col))

    def get_board(self):
        return self.board

    def set_board(self, row, col, value):
        self.board[row][col] = value

    def fill_board(self, index):
        if index == Board.SIZE*Board.SIZE:
            self.complete = True
        if self.complete:
            return
        
        row = index // Board.SIZE
        col = index % Board.SIZE
        if self.board[row][col] == 0:
            for val in range(1, Board.SIZE+1):
                self.board[row][col] = val
                if self.have_duplicate(row, col):
                    self.board[row][col] = 0
                    continue
                self.fill_board(index+1)
                if self.complete:
                    return
            self.board[row][col] = 0
        else:
            self.fill_board(index+1)

    def swap_row(self, row1, row2):
        for col in range(Board.SIZE):
            tmp = self.board[row1][col]
            self.board[row1][col] = self.board[row2][col]
            self.board[row2][col] = tmp

    def swap_column(self, col1, col2):
        for row in range(Board.SIZE):
            tmp = self.board[row][col1]
            self.board[row][col1] = self.board[row][col2]
            self.board[row][col2] = tmp

    def randomize_board(self, steps):
        random.seed()
        for step in range(steps):
            val1 = random.randint(0, Board.SIZE-1)
            block = int(val1//Board.BLOCK_SIZE) * Board.BLOCK_SIZE
            val2 = val1
            while val2 == val1:
                val2 = random.randint(block, block+Board.BLOCK_SIZE-1)
            if random.randint(0, Board.SIZE)%2 == 0:
                #print(f'swap row {val1} with row {val2}')
                self.swap_row(val1, val2)
            else:
                #print(f'swap col {val1} with col {val2}')
                self.swap_column(val1, val2)

    def serialize(self):
        s = ''
        for r in range(Board.SIZE):
            for c in self.board[r]:
                s += str(c)
        return s
    
    def deserialize(self, str):
        assert len(str) == Board.SIZE**2
        index = 0
        for row in range(Board.SIZE):
            for col in range(Board.SIZE):
                self.board[row][col] = int(str[index])
                index+=1