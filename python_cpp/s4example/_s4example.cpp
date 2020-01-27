#include <string>
#include <sstream>

#include <pybind11/pybind11.h>
#include <pybind11/operators.h>
#include <pybind11/stl.h>
#include <pybind11/numpy.h>

#include <pybind11/stl_bind.h>

// Include headers for our various compiled sources.
#include <fake.hpp>

namespace py = pybind11;


PYBIND11_MODULE(_s4example, m) {
    m.doc() = R"(
    Internal compiled tools for the s4example package.

    )";

    py::class_ <
        s4example::FakeCompiled,  // The class to wrap
        std::shared_ptr <s4example::FakeCompiled>  // The smart pointer to use
    > (
        m, "FakeCompiled", R"(
        Simple fake class.

        This class is just a fake example...

        )"
    )
    .def(py::init < > ())
    .def("make_data", &s4example::FakeCompiled::make_data, py::arg("n"),
        R"(
        Make some data.

        Args:
            n (int):  The number of data points

        Returns:
            (array):  An array of some fake data.
    )")
    .def("__repr__",
        [](s4example::FakeCompiled const & self) {
            std::ostringstream o;
            o << "<s4example.FakeCompiled ";
            o << ">";
            return o.str();
        }
    );

}
