Describe "Verify containers contain expected files" {
    $repos = @(
        @{
            file = '${env:ProgramFiles(x86)}\Windows Kits\10\Include\activation.h'
        }
    )

    it "should contain <file>" -TestCases $repos {
        param(
            [parameter(Mandatory)]
            [string]$file
            
        )
        $file | should exist
    }
}