// The MIT License
//
// Copyright (c) 2013 Ryan Davies
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

SpecBegin(BSTInjector)

it(@"injects instances with a matching dependency", ^{
    NSMutableArray *dependencies = [[NSMutableArray alloc] init];
    NSObject *subdependency = [[NSObject alloc] init];
    for (NSUInteger i = 0; i < 10; i ++) {
        dependencies[i] = [OCMockObject mockForProtocol:@protocol(BSTDependency)];
        if (i == 5) {
            [[[dependencies[i] stub] andReturn:[NSObject class]] class];
            [(id<BSTDependency>)[[dependencies[i] stub] andReturn:subdependency] resolve];
        }
    }
    
    BSTInjector *injector = [[BSTInjector alloc] initWithDependencies:dependencies];
    id result = [injector getInstanceOf:[NSObject class]];
    
    expect(result).to.equal(result);
});

SpecEnd
