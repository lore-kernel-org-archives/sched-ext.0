Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B559B232395
	for <sched-ext@lists.linux.dev>; Mon,  4 May 2026 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777911362; cv=none; b=Lz1UCTP1T5neV3HT2re6Y08Kmpp2oUyOlUBR3GWZE9SEP3hyDC/pMYXRumAfVC0471TLOitFeNnalTn7l8ZVhyRni1rdQS1RUDb46ZxfhRIpmqYrbUUOMEdGtgLtIXlBQtG1oMXod5UnVuZ90XJQz/xjBxN4hxQWgi5rzllVezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777911362; c=relaxed/simple;
	bh=sTDR12sjqTwMm+r4fFdhIkquUwcGi7MUb8j8uCRfvQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6Nk7rUJ/kt2RA6ZPENuWUm9ooOU2l/4fcVtbZEKlH2ApDzP/VzGk/+jgMjPbcNfxvDg/NvBhFQK+L2V3JAE9BT7spwfoy2KdsND2YwQoyOD22rPZjnOgEsMdbmb+oKE0OM85LfQvibS6xxHeP0o3aA27IQqcY+zfHtzDJQ/qpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6eQoqfj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6eQoqfj"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba0fc8b1f0so8910995ad.3
        for <sched-ext@lists.linux.dev>; Mon, 04 May 2026 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777911361; x=1778516161; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSUUEhTxPVnTNICfoGoDgRMvs6IfWcbouR7fQZ1ACRQ=;
        b=j6eQoqfjWTXinT9kTs/W8WtBhbZ5n0EjfsIW+KFJ6Cf+MMaf5pSvCNfjLB5EVDwTua
         /+p4kITbOeXJ/OUbqtG5QB8A8aBZ7uRVZvrUZZrBEiBJH1hcFmx4UbjHmSx3uRi0EQmw
         /gdY1npbKI3lKsXf67MSjY1Aum/zPe0Uik1TWZGD5zPEhjhgES4zaVMmBvehLj7EXA8B
         MNB7uSFvDK1TLBn5ArPeuMV6eFQYLUmIUkzTXhjBXQSd733pNEqpiAZA4Phr43qE7kQW
         N8dKeCbJk8HcybA1HSI8LzcT2UcymJnn+D3dmgW9ZD/7+Lig+kpSBa0DU92RybKxskZv
         2jpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777911361; x=1778516161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSUUEhTxPVnTNICfoGoDgRMvs6IfWcbouR7fQZ1ACRQ=;
        b=TBmwh5ZUAAcBq67Uua1viGSIVTYK25rXxEQZJrXGmz0pd1Z/Pn843bEn98XhDrrGEV
         IDHfkN58w+fVPAme8/PSUrcJe6wnmi6d6f8Ec35V1pu5n9RmyfgGCOq1FO6zaIbATp8M
         NRMChUvxRgZLvLH1sxrDY3LB2kg7p+meawdXbg9LiOLd8W1+8zE9jY0UGp33oc95nl5Q
         QF7Pdj5u3TZxodeujQgc91eElGdf0B8Deipr0FNUJoOjkW7TXnzNi/T8hhvkLScwTzKD
         Eb31N2ELFmYHvPbuooIjfSR2fXvnxVsskqhGjcN308NAqRxVmFJuXtaHTPZRzpTywXUB
         1xEA==
X-Gm-Message-State: AOJu0Yw6EKpLtMxFEWNMhxco1AE96++iSHnAgqvphvqyL23nXAZSYWf1
	Skx8NCOVOljgTOPPKBy3WCC8GGLwvZEEYQwENrqQl8ZGl7r+htFAmDihllxLAA==
X-Gm-Gg: AeBDievXMJJCDZ36eL5PI208wgRjvPaiJgASLM169u+uOwJlJlNgWWxw8jozAfLJ9a5
	rO0kRofv2YL7y3liKzHIPvlvC6547uQk+HG6aLD30AeOKx5ig8KtTnZi+/uz2kuIUVaNBjaSgnL
	xqljSaMByfqEPQ+tPNizr3M87JEvz773RBb8cnkh9hp+52RQVxQ+Yvan5vXekOWURqvyBhTLPGB
	KEcIOPRiEdhlQA4YMXkqHqAVZXFjayqlCHPJdPkrbyLJizi5bgXf5tjGi+7Uwvxa1SLaNiW4TcQ
	fqCchgaBy/HDiFr5GkElwfE4vXHglaQ9KYD2WA5Ep+HwjRFMs/d5wdpeXMWyJJ4iQb1xaSqspSE
	w58tEMzuOkmXJZGBJHKHn56sGJ5HQXZJLFdExtNOeuwlm3zZRHDJ31J2ayD7As1KHOtx6+NYu90
	33I1EnscYCwavOYDKQpLFaS5RoveNlqYvYR5B7SlV22rPoBV0mm+C1zuGdNHPJ/g==
X-Received: by 2002:a17:903:ac8:b0:2b0:59c4:e9dc with SMTP id d9443c01a7336-2b9f25e22bamr102593345ad.22.1777911360727;
        Mon, 04 May 2026 09:16:00 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d123:1fb:b1d3:aa01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba4ccf6a1esm2385745ad.81.2026.05.04.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:16:00 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH v2 1/2] sched_ext: Normalize exit dump header to "on CPU N"
Date: Tue,  5 May 2026 00:08:19 +0800
Message-ID: <20260504161543.674488-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260504161543.674488-1-yphbchou0911@gmail.com>
References: <20260504161543.674488-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unify to uppercase to match the UEI output.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 45a2668284bc..48c65ac8e230 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6486,7 +6486,7 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 		dump_line(&s, "Debug dump triggered by %s", ei->reason);
 	} else {
 		if (ei->exit_cpu >= 0)
-			dump_line(&s, "%s[%d] triggered exit kind %d on cpu %d:",
+			dump_line(&s, "%s[%d] triggered exit kind %d on CPU %d:",
 				  current->comm, current->pid, ei->kind,
 				  ei->exit_cpu);
 		else
-- 
2.48.1

