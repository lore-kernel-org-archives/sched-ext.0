Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD5E322527;
	Sun,  8 Mar 2026 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772937925; cv=none; b=DbfIe7Z/0LaMIT2ofq6rGHDdS1UpvTnqgV+Xc6IuqPlVlzODfMAl/R8js/17JUIkyGBBU5fUq37f5I43OfKbeB5GCf0FYrIEjMo13GhxbVp2h9GowH8hgPFDp72lwi0dMy1cZl8n6Nzu3wJclk9RGIqax1yx957ASqChh1ayHfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772937925; c=relaxed/simple;
	bh=m2o6O9EFwJ6TJfQ89sD42YpInVZ5Xh4IaRYa+DcWKPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZrtxZyjNgBK+YeRbVDYnU4PHf9rykv5jTP9K1naezMMB4NLJsAmqAxDNC01eR5VgBvC7BdGjsNTQajfV/z8WxoyDnAm1UE6LF5PPAmwBE8AatudTlVVWlxVbV3I7H2C050Q7Yab/Ikpi9/IcIP/Mn3Y3Ke8HO6BtvsSfwUNugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0R54gOa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0R54gOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BC8C2BC9E;
	Sun,  8 Mar 2026 02:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772937925;
	bh=m2o6O9EFwJ6TJfQ89sD42YpInVZ5Xh4IaRYa+DcWKPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0R54gOaT+zuSVNGNThgDB2khcYeqMlaOUFC8Y+C0mN5SYtIqc3IL3okLihbZR2tD
	 by+bB1DOtmjb+zSBkxRUstpLLFrqCB5bPA1y+daOMgyWjcVlu/I1ughFWqypVERE5q
	 sHyU8pw3rgWLB74Fd9YK/dH/b6rMEOgd9/3xdT9KsHXfqQrz27AdcGZZ/gj3Zakvi9
	 Y4b4W8sOntvXcrorRhe9quAtflBtKj91laDorv0Npi/XpwAOBBfhmn2Y21hQSj0loG
	 ouvfrVgaNKy3Ml2yQRPIDGfUL3OGPqn3snOe+pCNz8/ipDY+lRLNIz1hysQWMk7Cbu
	 3I35Ua/UtoRSw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] tools/sched_ext/include: Add __COMPAT_HAS_scx_bpf_select_cpu_and macro
Date: Sat,  7 Mar 2026 16:45:17 -1000
Message-ID: <20260308024519.1980564-5-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308024519.1980564-1-tj@kernel.org>
References: <20260308024519.1980564-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_select_cpu_and() is now an inline wrapper so
bpf_ksym_exists(scx_bpf_select_cpu_and) no longer works. Add
__COMPAT_HAS_scx_bpf_select_cpu_and macro that checks for either the
struct args type (new) or the compat ksym (old) to test availability.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/compat.bpf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 2d3985be7e2c..704728864d83 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -266,6 +266,14 @@ scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 	}
 }
 
+/*
+ * scx_bpf_select_cpu_and() is now an inline wrapper. Use this instead of
+ * bpf_ksym_exists(scx_bpf_select_cpu_and) to test availability.
+ */
+#define __COMPAT_HAS_scx_bpf_select_cpu_and				\
+	(bpf_core_type_exists(struct scx_bpf_select_cpu_and_args) ||	\
+	 bpf_ksym_exists(scx_bpf_select_cpu_and___compat))
+
 /**
  * scx_bpf_dsq_insert_vtime - Insert a task into the vtime priority queue of a DSQ
  * @p: task_struct to insert
-- 
2.53.0

