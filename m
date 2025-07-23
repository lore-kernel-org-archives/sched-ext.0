Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840892E54C8
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272490; cv=none; b=cqBcIwS1tgqlQPYn96Ux9c2vuTlcVkp5053ZVXOu+krP/wNs0vzcM8gq9Kmhx9538D66gyEByGPltQ44jqSote1P06dkvlpa8t73/9g2Sfkf1Jpmw5q4O/ZZyEK7UxVNTwzBdz/3K/PDcUt7OJYpXbzxYpbEfz/hRPuFuTmDXEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272490; c=relaxed/simple;
	bh=nusEFJD5osWlzAuAa2sx8tiK+doL14JyYoGlVFauk/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khTBO/WzKEfiButQZyvABgfkLU0mv/ow2t4GJVTecgW3ruxc791aoXnH9OUoq/4JgpgmbkGgd2oOLoNF2b6rIfXd6ZFRtwrTZQ8z6DDMnP2U4Xx0xSzm7JYEF5EbU+unCD6wYK4FPH5K/foHmqdbG8MG/sFlWBrGTAcM6Y2+Gs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4gs8Ant; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4gs8Ant"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748d982e97cso5905417b3a.1
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 05:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272489; x=1753877289; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0AN6nr1QI6e4PH1wMYFBZM1c8nKIhU/mXByncA6e7E=;
        b=i4gs8AntpCC49sqfguLkZhcu3+HcXeL3aC7KLKeuOSERnUkDUSYzHTjWeLFZv2Tk+A
         DHDpLlCJmu4eX6E35V9zaJ88qAAfcF+O57+0q5Ot18c8Nue0ofZUL671vFQQRd+aGtqN
         pMD9Xjpr5ONMWYkUEOjgXklcLfb8W9v+jCaLJFqHoCL6qsa4nVoEbwybnFjNbXLgdeXy
         cKohMU3zyFZbg6uN8Ku4hJDHbll3AMAcML1aDMbg7q+o7yMwGePu/15f8HcntHgRNt/9
         f/Xoskhddv8Nm22JhYIiDbhTlZt22GtLWDuV294ePNbW7gAW1QrFv4zCO2jzbm+8rmWt
         u5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272489; x=1753877289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0AN6nr1QI6e4PH1wMYFBZM1c8nKIhU/mXByncA6e7E=;
        b=xCupqpL0gLhj3M4ZTAOUNDM0/xhPK6TAvjClMqeD9uKgERRE2owHO0YNirmz+1fI2k
         xCeMRqVZDeAxH0rGVnJE1gIZ40NqBS08tna9zCK2vMDdT2dnlF62jZ8AsWG7aFfm6fGH
         xOpX9G+GQjFuk1jNYyUhKYjmRswWC9xvEejBKOdvh2p4R2T6fP9rY+PxFxYXGBNuhPH0
         bkeIEkaOoVJbPiMTaQDj0b3Oi7Mjl+t69nNNPaD9SJ+0SLi8eP0gLa/R4M+ZscknXXBT
         eLmoM7JrR/maSctyIj98L10K9aVr9OVqrX4hmIADJqeaT7WH4alcrQPcnWL/9Fjieh9S
         wICA==
X-Gm-Message-State: AOJu0YzJLQPJgxauE1+tzWjMyphCmucGHjLeB3ngBnkxSe/c6Ba/KH1M
	OrUVYDu/Bhe2Z38X3pUhuNyMEsrSMa8w0Gg9eFPVd+XFpUU17eyLnr08mClJu3de5r4=
X-Gm-Gg: ASbGncvXEpNULlVKT1QUjVTRDpAhQN/lN6gt6UKT2eGXZbAUFbFEDTWnmlxGoHwgD/P
	uSTcJ3MZKvKFYa42Wg7O4sHsnJiE1mBfoOOBN4xZBBmk57TOOZMeMYiWcWrzTCl6BbwA91JtI8N
	4V33y0MubD+glAqafu4MoImjk+2HEU7rrHpCrekuK7zOhM866oUK/VHKqIlpwLSFtMnQhUK4kYK
	cwd7fyJy1tnHJKQnH165qN3oAxdVG03s3pYBDMC6OMJKmKBxqoVgOms2L+UC6WnnD/qXJ4DBbGJ
	Gx/pUglIwvElNbPebx3mridUdy7YCtViONHX8RdXYLWhjlDASO4FGEkNqKeMxMlITQgxR4Sr3r0
	V+Sci/d9NR+5RoS4ozbo/i9FdIEvnxK+MnV0FdUvaa7iHZ4UBTjms
X-Google-Smtp-Source: AGHT+IHllDurbtQKjniLolsr+CeFF1l0gCtRz17KVF3WYvdDtwR4PQv5gZ3JhaSDXzJXI0q65ycNUA==
X-Received: by 2002:a05:6a00:ad0:b0:748:33f3:8da8 with SMTP id d2e1a72fcca58-7603450a7camr4423072b3a.5.1753272488534;
        Wed, 23 Jul 2025 05:08:08 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b3f7:1e17:c773:7c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569e7sm9589040b3a.90.2025.07.23.05.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:08:08 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 09/10] sched_ext: Sync with scx upstream in tools/sched_ext/include/scx/compat.bpf.h
Date: Wed, 23 Jul 2025 20:07:45 +0800
Message-ID: <20250723120746.52847-10-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250723120746.52847-1-yphbchou0911@gmail.com>
References: <20250723120746.52847-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sync via ./sync-to-kernel.sh /path/to/kernel/tree, as suggested by
the upstream scx repository.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 tools/sched_ext/include/scx/compat.bpf.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 9252e1a00556..36e0cd2fd4ed 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -38,6 +38,7 @@ void scx_bpf_dispatch_from_dsq_set_slice___compat(struct bpf_iter_scx_dsq *it__i
 void scx_bpf_dispatch_from_dsq_set_vtime___compat(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
 bool scx_bpf_dispatch_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
+int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym __weak;
 
 #define scx_bpf_dsq_insert(p, dsq_id, slice, enq_flags)				\
 	(bpf_ksym_exists(scx_bpf_dsq_insert) ?					\
@@ -82,6 +83,10 @@ bool scx_bpf_dispatch_vtime_from_dsq___compat(struct bpf_iter_scx_dsq *it__iter,
 	  scx_bpf_dispatch_vtime_from_dsq___compat((it__iter), (p), (dsq_id), (enq_flags)) : \
 	  false))
 
+#define __COMPAT_bpf_cpumask_populate(cpumask, src, size__sz)		\
+	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
+	 (bpf_cpumask_populate(cpumask, src, size__sz)) : -EOPNOTSUPP)
+
 #define scx_bpf_dispatch(p, dsq_id, slice, enq_flags)				\
 	_Static_assert(false, "scx_bpf_dispatch() renamed to scx_bpf_dsq_insert()")
 
-- 
2.48.1

