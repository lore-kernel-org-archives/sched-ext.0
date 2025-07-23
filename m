Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37815A87C
	for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272486; cv=none; b=lIorpK9rvlEY+RzrO3QnxcDGcoQndfUIPycTx3cgniwwQO7QVp0TTzmeIehF406Wwjrhec1GyQvDwnR6G+Z8GQ56h0o7aoA8yCoyOih+QTdydAjIedOm8rTuufOi7RkFZgox3Buo5JykFWvz4dIvV+zkSreIh87UvQki9ISfSPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272486; c=relaxed/simple;
	bh=dzpsJKDbVnHuubVOprnqIRs8myP6uVBWmqQZ5oI16IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDhnG3Mp8YFU/JlonAhaLbFckFWFzRa8GueTtSPWdg4EN/5fOQjhXx06qoCvZ+nKXqyxH0WERY4cgDz5fJ9xW+2CKIlkw2BJtY0iuBh2JX3MLj2TfuzFiQeYWxSemzPYeuo0jteBuEDce1Unt3AB9VJgRmJaza7wjGZZOKH6NgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2EwJ9lD; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2EwJ9lD"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-748f5a4a423so4142864b3a.1
        for <sched-ext@lists.linux.dev>; Wed, 23 Jul 2025 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753272484; x=1753877284; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LPAyPjJKW+K0dYMeLML1Uq0lPOL/QvSkfPkJwrZNdE=;
        b=j2EwJ9lDjWFmntJ3G1hMcIk5NZkGCybqgifjb847gniIxrkIlyaZGYVqItXXJUtsdV
         V3YjhZ5zO+WSQ2FI+K+YqmIX7dRLG0pc+6AZDqrRbWtxOYPTaxMYpDkjvnW+wWwyzM16
         +lPogYeAMSdUNikaFitoV04/OvAxx4xaFgJh9H7mvy4006AK+NUOOH6ZI47tl+8qPHUb
         ekTo0qmtL0F4Wznr0BVx/hyOTwfNgTygm0Olmx7Z9tG/gQZLZiqswmvq5XHDWq0BigTe
         QIQ2jaF8jezDHtKPCZ/V5FLImbdEYOkvBM2GneW6Z9TnsRkyYbvvklStA+zMwAzbJFkP
         /2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272484; x=1753877284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LPAyPjJKW+K0dYMeLML1Uq0lPOL/QvSkfPkJwrZNdE=;
        b=n32v8XxDLoxbWbJK03s/KcHhESeu6wjNNwdz0cTCCSY5VaM1rgBoQfaI+K/8JB3MKE
         27U6Ld1/f66mpwbGdqOsn2CH6AgHCo24oaXQhTYlmYhb7DbFPk04SW/GvSzHfUZ87uaw
         UvHYz6E3POGLjSRK5WVVbbAK2O2bRIszehC+5DvNFbtyg5thtUZD3xJtdcn3lngevbXc
         fDdzMdayKIh7XYVMjpZEwppv6HVnvZuzatx/fTWL6ZV5fd4LSllp+Mm5umgm8LpGEHOQ
         RbO3FmqpLEBmmXPxwMyfjEGE1Pnjs0cswR+ZbM6Qr3iElvxV+902fAqhYSZdtANXpxdg
         0XHQ==
X-Gm-Message-State: AOJu0YzCSYMrn/pcl+YsBYZ4zK2VIo8FiJ5kNYpCIjSS1j+EAH9JFgkZ
	FpILx95QkVfD9es7uqn6EyWY8/PBBD9SPbClr8yteCtD75TGdaa16Xul8j+LDazrfLg=
X-Gm-Gg: ASbGncv2dQXyf9lIY1Z+VANTOfIKbUwl5q5ac5ZtMSESPohXD2PqbbRetetiqvz30ea
	nKzt0x07Es1+JTLK8X5+o04ScIF001ubwXwJpkkGF+y7EGn6ivKVEMEDDMa7wp5Z6j+mISvW6NZ
	FgxQGXn/i/1zfV4i4SeFQ2c3L6ubpVo5cvl5MKo7+UI7v3JKoPuhaVBHGaaUOPeD2X+jWHbztH6
	KL5UdUDM3KDIeZB00fzNnaOFgJYfCjQ48orA8hiYGlTZsiizHq1EH0L7cENvrR+CKawrVtUMJgt
	fiIzSE2KJHSkybEOgiqfjau4Nr2s8vV9+slaElACVdc1jGS3or8yS1Owm1FCWDzUOfnQ4t8X/HX
	Nlb1W4ukF+yemYEzHIqATnMfq4EqozExSOCZWVm2hyxm98ccbpwtO
X-Google-Smtp-Source: AGHT+IHQCz/Awb0dBdJOkKRP70uZLFa57YQ0bSn4CiRZvah71Rxb8IUQSZsObSAg+2/bwCBEFQJObg==
X-Received: by 2002:a05:6a00:39a6:b0:74e:a9c0:9b5c with SMTP id d2e1a72fcca58-76034cecf42mr3500138b3a.13.1753272483467;
        Wed, 23 Jul 2025 05:08:03 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:b3f7:1e17:c773:7c18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1569e7sm9589040b3a.90.2025.07.23.05.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:08:03 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 06/10] sched_ext: Sync with scx upstream in tools/sched_ext/scx_simple.c
Date: Wed, 23 Jul 2025 20:07:42 +0800
Message-ID: <20250723120746.52847-7-yphbchou0911@gmail.com>
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
 tools/sched_ext/scx_simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/sched_ext/scx_simple.c b/tools/sched_ext/scx_simple.c
index 76d83199545c..06d4b13bf76b 100644
--- a/tools/sched_ext/scx_simple.c
+++ b/tools/sched_ext/scx_simple.c
@@ -7,6 +7,7 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <signal.h>
+#include <assert.h>
 #include <libgen.h>
 #include <bpf/bpf.h>
 #include <scx/common.h>
@@ -41,6 +42,7 @@ static void sigint_handler(int simple)
 static void read_stats(struct scx_simple *skel, __u64 *stats)
 {
 	int nr_cpus = libbpf_num_possible_cpus();
+	assert(nr_cpus > 0);
 	__u64 cnts[2][nr_cpus];
 	__u32 idx;
 
-- 
2.48.1

