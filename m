Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14051318B9B;
	Sun,  8 Mar 2026 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772937922; cv=none; b=biSrypifvDHz7q0Z3RScf3fye/0SfXuSLdHMVL6kgRdAXUiJ0o9NrR7we+omKFNgCbb0VCuVIf8RFq+g/sTTjc4d0enrfrkhW0I+McueccXkgR/LmHQ7Q7FU5mud+iEV9Ufj6RCL3rAj0txdulqpAe2M2OnRJOoT8QeHQ271SiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772937922; c=relaxed/simple;
	bh=zNDZpjgGe+fN0dADG09Y0W0W87U7NDvkEoIkanV/pN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sW2aZIsVdJ8rYXfqgVIBxXPlWtUE0jEMYU9csTGYpcIAKXsYNlD76L3amJNsjrxEpo8H7Uy8NQsZ349hEYmO+1mpIhKS0POFAIoCOYzYohSqrjz7YOAJ7K9DixdlPAQpAYGu0Selsin2M+JDkDraHz2X6aNJIdYqjllPUbFL17U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3+LNcTS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3+LNcTS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C97C19422;
	Sun,  8 Mar 2026 02:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772937921;
	bh=zNDZpjgGe+fN0dADG09Y0W0W87U7NDvkEoIkanV/pN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3+LNcTS37IEHTPel6ZCV1ZfeWcOCiSCsTghVOU1YmHG4GsEJnKHr34MOTx4WKNjp
	 10tuGpc0lcF70SzNti8kCwzFpgqN2AOaxEjJEEUnCX/rnYYBMCWCfVzHhP6ck299py
	 JnlWB2eMqqnt7Oiumeb1/TSmcdSWtymn5WQoxQMphVm5GKk9YjdBw/JqaXyfdzucX1
	 LU/ZiZJidRBh6MZ/wclKdJDHxojAxM3vDMKMWEc8LkqVC+r5NljBkTs6DpMKjrV9Nr
	 /LqV4x+i7Z7/YBwmJb8U17Ls4BykAwMZCMOtJ1/r2xcDZaF79dEyKZzcvZbiGcWTTE
	 KGbKxIKhyFuYg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] tools/sched_ext/include: Remove dead sdt_task_defs.h guard from common.h
Date: Sat,  7 Mar 2026 16:45:14 -1000
Message-ID: <20260308024519.1980564-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308024519.1980564-1-tj@kernel.org>
References: <20260308024519.1980564-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The __has_include guard for sdt_task_defs.h is vestigial — the only
remaining content is the bpf_arena_common.h include which is available
unconditionally. Remove the dead guard.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/common.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.h b/tools/sched_ext/include/scx/common.h
index b3c6372bcf81..823251fc4715 100644
--- a/tools/sched_ext/include/scx/common.h
+++ b/tools/sched_ext/include/scx/common.h
@@ -74,10 +74,6 @@ typedef int64_t s64;
 #include "compat.h"
 #include "enums.h"
 
-/* not available when building kernel tools/sched_ext */
-#if __has_include(<lib/sdt_task_defs.h>)
 #include "bpf_arena_common.h"
-#include <lib/sdt_task_defs.h>
-#endif
 
 #endif	/* __SCHED_EXT_COMMON_H */
-- 
2.53.0

