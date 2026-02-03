Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1441368293
	for <sched-ext@lists.linux.dev>; Tue,  3 Feb 2026 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770101875; cv=none; b=CzRLlRe/8TxemWqSgBqfxmmIgA6OsxtHDPEpn9Lxr9QNGEwMsguio3z9EE6rNh0ovmFtNCPf4Fs2kHRES6/e3cSlK068ejJ7rq2lzl/iKCRpBXGSdAE9Yh/QMTYPJTyeL2BhZUoyEN5ClIGyuKornugGrerfmeqAu6NIrteIRl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770101875; c=relaxed/simple;
	bh=vvEVKjJCtQo4nmuo3z04CydsrpGhwrX7+I/UCM695oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRXGr3as/d4HCC/EcXxT/pH6ihQs6weYystvlJhN6ni1CidNGpLodZq+nSkP6OEcD5lIpHQNEguXkKPwQSGluGDGe3UuWG4oMhgi//PxGMr9uauCHZt+frKRwSjjFpFt74F4nwZaVyeeTcGOzt3Zw9PfK+BYvPFstrL4wtsLnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTEdBoS+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTEdBoS+"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81df6a302b1so5024358b3a.2
        for <sched-ext@lists.linux.dev>; Mon, 02 Feb 2026 22:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770101873; x=1770706673; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtxdwbyBhJCjJN9Ud01S5+F/PCx615rL1edEy0Sb+qY=;
        b=OTEdBoS+caMn0Q8RBV8UvmYwAijaxuJ7AfhQs0JLx5coJ31M/n1E89TsCY1HcPFr6i
         KoCgOSlVdq+9aixNUpst1/GgnviWNIiYB92kst5rZqFisMP0Wc318Zs6U9fEXAQf4mmU
         5AlUchKDDiwzF0ZYMnoVeE+WBHeMDIjPimdM/WXs7mdfG5NYh6xyQ1R2nrzXwjqhjLWM
         dE9atQcljsl78GrsiLXc4qQKU7B1ye/kvhxl8CXb3M1vdxZbTqENsiNCGWvt5QiJ/y5l
         bwkiE8OrljAoDAD8TCqPsox091s2pnSybH9H8XYzfZP/hgrKMlJd27JGzoC0GGX5+cxE
         pr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770101873; x=1770706673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtxdwbyBhJCjJN9Ud01S5+F/PCx615rL1edEy0Sb+qY=;
        b=xSF3+HfWa62gyJ77cnuD3Y4ZZ+uyo0UI5k2YnkNL927KIZPDZmg+mDhULKYvfx4OaM
         Nr2BOCa921Ywgc1ItQKHMZQO+3QxBVoeojexNFjPA+jq29R6FnETqzWPN2ucEokDNyku
         QUtsUzH5JhrRd1d1DQklcEHxWvrfCENFU9kteo4u/ydAi5yDBG6ZU3BcV9wN8iAg/0e8
         xKRkA7nuSghGJRs7BmbUTMY0dfDU45i6uAPWgaYeXT+V8Cs9W8XtyZxuW+jUcVloOa/G
         p6bTyQCVHJo+1dIyn+sGZzdSjoS/9eWp7NN+OrEw9vI034TfRNyv7Y5eXNtsnY9+stHs
         zSzA==
X-Forwarded-Encrypted: i=1; AJvYcCWh9hcGtPvsWcHOrC1JB8Tnd+AL2CCutdL7CyZdnJFMQqy3rKy1Wm7fIcVcI8E+NPA0CjbeOGBpbyI=@lists.linux.dev
X-Gm-Message-State: AOJu0YysIWJTf23Wtd0Wc20q70t5/oFOt0XkJgc8vBfrdwrz4PoFW+0m
	PQEWTdmgrAXQWxZ0UIs7rli0zbrIthKl0P5GTvXeGXrJJDdKTBNCJni+
X-Gm-Gg: AZuq6aK5GTog1HyqP8mP4GZaCA6Y91JBBxfpDvqsp1AgvoFiypCmuL2QgzD48UOwCTC
	xSm/XgR8aHBWQ+HaPrKzVx4Oi/PpPe17piru1EsiZOkf0FOUd49DPMxg9ob2wotIMD/B+OqWJBb
	JfiqCZ5w1/Vjy9l0rWnq0cWdixh9g74l71wMDjMJa6mKwHiyDDyCGpT3XJN9Tq0DWWD3ZKDCCgE
	EO6VEbs4M6oW3jQhgyfomqmS3tp5nWjmfIBTzdYqvJhqqEdw3EmWMT1lDS8uUyBL21QlBFYL29e
	iwq6J8IIa5noehQu8iFxR/35WfyCzJcRm9qaOeZl0wm0AzqGKB3anJxgzmFpgkEeazAvtcOcd5t
	qHXCrHGIdnTz0tQpI9gdFv8ITsZNs9lrekL+0jL2tXg6RvOl7mvALiJHeisq9jeJlgoItqebaJa
	M5KZQdU9x/LP8FoFZDZlh5LJoVzLtGiTTQPjvDrzql/OtlGOSqer47mNYBZ9ZguCI=
X-Received: by 2002:a05:6a00:1d9e:b0:7ef:3f4e:9176 with SMTP id d2e1a72fcca58-823ab72e98dmr15316865b3a.49.1770101873258;
        Mon, 02 Feb 2026 22:57:53 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c32944sm18114225b3a.57.2026.02.02.22.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 22:57:52 -0800 (PST)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: soolaugust@gmail.com
Cc: arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH] tools/sched_ext: Improve BPF verifier arena detection workaround
Date: Tue,  3 Feb 2026 14:57:21 +0800
Message-ID: <20260203065721.46089-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <F3AA31BB-AC18-4CD7-B3BC-9A39CF9959B9@gmail.com>
References: <F3AA31BB-AC18-4CD7-B3BC-9A39CF9959B9@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace bpf_printk() with volatile access in scx_sdt scheduler's
BPF verifier workaround to eliminate console output while maintaining
the required LD.IMM instruction generation for arena detection.

This addresses the side effect issue of the previous hack while
preserving the essential functionality needed by the BPF verifier.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 tools/sched_ext/scx_sdt.bpf.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/sched_ext/scx_sdt.bpf.c b/tools/sched_ext/scx_sdt.bpf.c
index 31b09958e8d5..13d3060c99ff 100644
--- a/tools/sched_ext/scx_sdt.bpf.c
+++ b/tools/sched_ext/scx_sdt.bpf.c
@@ -64,14 +64,10 @@ DEFINE_SDT_STAT(select_busy_cpu);
 static __u64 zero = 0;
 
 /*
- * XXX Hack to get the verifier to find the arena for sdt_exit_task.
- * As of 6.12-rc5, The verifier associates arenas with programs by
- * checking LD.IMM instruction operands for an arena and populating
- * the program state with the first instance it finds. This requires
- * accessing our global arena variable, but scx methods do not necessarily
- * do so while still using pointers from that arena. Insert a bpf_printk
- * statement that triggers at most once to generate an LD.IMM instruction
- * to access the arena and help the verifier.
+ * Workaround to help BPF verifier track arena usage.
+ * The verifier needs to see an explicit reference to the arena variable
+ * to properly track arena memory usage. This generates the required
+ * LD.IMM instruction without producing unnecessary output.
  */
 static volatile bool scx_arena_verify_once;
 
@@ -80,7 +76,11 @@ __hidden void scx_arena_subprog_init(void)
 	if (scx_arena_verify_once)
 		return;
 
-	bpf_printk("%s: arena pointer %p", __func__, &arena);
+	/*
+	 * Use volatile access to generate LD.IMM instruction without
+	 * producing console output like bpf_printk does.
+	 */
+	(void)*(volatile void **)&arena;
 	scx_arena_verify_once = true;
 }
 
-- 
2.43.0

