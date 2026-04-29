Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A955330644;
	Wed, 29 Apr 2026 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777442886; cv=none; b=GOvUkMwzjR01jOXfdKmkRVsxzO9FyS6FunqQCcItyzDuONwJUYLgrxV8UDMQnNTVaMsXJ682nyr8FjZdZmKveshPo9kBx0vGH8Q2mLrRCouZAMm1ngM+MA7FUAnV5Tf0fvXdHsStxeu5QblNciwZ4yXPzYJUw+HOvSgEM11nYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777442886; c=relaxed/simple;
	bh=+P8W/lT3bxuFm/Ngj7kKpLGTVtYYOj54bCstVxBja18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAmlGdU7EQVZBeye2IhkYnnDE5BgVHEW8fruXgZ8tgkm/yJtVy+L7GMHf8G1xAihu+847y2INIDJa6hmbCrsX2C9TfL1LqFs3UWiyhyz/evnZMQGiMBZVRinJP5PHXCHDiYkBJiBn6X32JsQl4Ag1noQfuWK23k9tYDi+kJSV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SgxJBHxc; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SgxJBHxc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gAy3VZ2Jr47jr7y04kRS3/RIQobp5zpizklhUo8OV4I=; b=SgxJBHxcZYyWIryahmDi6OREy3
	64vCiLEixazKcqyDNL9K+vD92JmR8DgPRwBGE/MjnnxC7d9BsZmVPD3IrcykTLA/O7kPloZLXrhFo
	hrB/mzuAaWjPWyPwmprZefffcUEDt4EVpjn/0HzD3g5iuTxpA8XZ1F41QK1sYk5GJBynBaTAKmkWj
	fbhX3r1jmfkwZQkOh6vuJYuhHPRitl8BvBQ0jxVqoKkWXwggnwx3oDKN4RMCx6Z4cq8AzFhCI38D4
	2FP4lUf1o7Yfd/Rjs7yJInG3qb/1Ur5YQR5BA9odZqIddlfibYHa6I13zUG9wVVKf+dzwH8lZ06M+
	zYfUQyjQ==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wHy5X-003k5h-3q; Wed, 29 Apr 2026 08:07:59 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] sched_ext: Expose exit_cpu to BPF and userspace
Date: Wed, 29 Apr 2026 15:07:26 +0900
Message-ID: <20260429060726.359024-4-changwoo@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429060726.359024-1-changwoo@igalia.com>
References: <20260429060726.359024-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend struct user_exit_info with an exit_cpu field so BPF schedulers
and the userspace report path can see the CPU that triggered the exit,
matching the kernel-side dump.

UEI_RECORD() defaults the field to -1 before the CO-RE-gated copy so
that running against an older kernel without exit_cpu stays
distinguishable from "exit happened on CPU 0".

UEI_REPORT() appends "on CPU N" to the EXIT line when the value is
valid, surfacing the most diagnostically useful piece of exit info to
any sched_ext userspace tool without needing to crack open the debug
dump.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/include/scx/user_exit_info.bpf.h    | 3 +++
 tools/sched_ext/include/scx/user_exit_info.h        | 2 ++
 tools/sched_ext/include/scx/user_exit_info_common.h | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/tools/sched_ext/include/scx/user_exit_info.bpf.h b/tools/sched_ext/include/scx/user_exit_info.bpf.h
index e7ac6611a990..98cab643c8d9 100644
--- a/tools/sched_ext/include/scx/user_exit_info.bpf.h
+++ b/tools/sched_ext/include/scx/user_exit_info.bpf.h
@@ -32,6 +32,9 @@
 				  __uei_name##_dump_len, (__ei)->dump);		\
 	if (bpf_core_field_exists((__ei)->exit_code))				\
 		__uei_name.exit_code = (__ei)->exit_code;			\
+	__uei_name.exit_cpu = -1;						\
+	if (bpf_core_field_exists((__ei)->exit_cpu))				\
+		__uei_name.exit_cpu = (__ei)->exit_cpu;				\
 	/* use __sync to force memory barrier */				\
 	__sync_val_compare_and_swap(&__uei_name.kind, __uei_name.kind,		\
 				    (__ei)->kind);				\
diff --git a/tools/sched_ext/include/scx/user_exit_info.h b/tools/sched_ext/include/scx/user_exit_info.h
index 399697fa372f..56a02b549aef 100644
--- a/tools/sched_ext/include/scx/user_exit_info.h
+++ b/tools/sched_ext/include/scx/user_exit_info.h
@@ -39,6 +39,8 @@
 	fprintf(stderr, "EXIT: %s", __uei->reason);				\
 	if (__uei->msg[0] != '\0')						\
 		fprintf(stderr, " (%s)", __uei->msg);				\
+	if (__uei->exit_cpu >= 0)						\
+		fprintf(stderr, " on CPU %d", __uei->exit_cpu);			\
 	fputs("\n", stderr);							\
 	__uei->exit_code;							\
 })
diff --git a/tools/sched_ext/include/scx/user_exit_info_common.h b/tools/sched_ext/include/scx/user_exit_info_common.h
index 2d0981aedd89..b98dd2973aee 100644
--- a/tools/sched_ext/include/scx/user_exit_info_common.h
+++ b/tools/sched_ext/include/scx/user_exit_info_common.h
@@ -22,6 +22,11 @@ enum uei_sizes {
 
 struct user_exit_info {
 	int		kind;
+	/*
+	 * CPU that triggered the exit, or -1 if unset (e.g. running on an
+	 * older kernel that does not expose this field).
+	 */
+	int		exit_cpu;
 	s64		exit_code;
 	char		reason[UEI_REASON_LEN];
 	char		msg[UEI_MSG_LEN];
-- 
2.54.0

