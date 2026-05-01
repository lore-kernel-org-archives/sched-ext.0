Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24214A619
	for <sched-ext@lists.linux.dev>; Fri,  1 May 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641393; cv=none; b=NLrZakt0VBemRUWy1QX4i9ulCEl5pDmS1CPkW4gEhxIBKsK64hU5NWHksHdwN7ZJJfeU8p7irHNkPL0elkgKAH5AaD/GWRhDgxi6C2aU5Y5NDQgY+Mie9hNrCUS/etR6q+VBJy9SeXfy4UjvMkLLN99C23UncAPhY6HSPI8pWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641393; c=relaxed/simple;
	bh=sTDR12sjqTwMm+r4fFdhIkquUwcGi7MUb8j8uCRfvQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=segNJvvtpRDWlBhy7ud8Ltb34bhd+Rtm5uB83ya4OsPnMu9HsQoI+wiG9PI8TJGEWMsBwRPLTPB8SscXbCDvP8+skXmag7RNoH0wTZW5d1KGr7v0luVhXwqIHcVGLossOTd8V6adIBlfcOAtqiT7HhSLr7L4hvWqLofAfSjHcOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jP5RWDnz; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP5RWDnz"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3650a4eb605so3228a91.0
        for <sched-ext@lists.linux.dev>; Fri, 01 May 2026 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777641392; x=1778246192; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSUUEhTxPVnTNICfoGoDgRMvs6IfWcbouR7fQZ1ACRQ=;
        b=jP5RWDnzortXzP1k+Un9yUWpkIECrfhVntYlIclk1WjYqPams6nlxOroSzexUdBTCe
         6cNd3OxJy24DQ9cmyq8bdIRPRaEGfOWjtSPPWKM0BEy5w33qYj+ibkg29kUkiajpcG1b
         8yTg4YTIqlJHRZhH038kTQwlce2T8BIden2ggwxiupUXwI12OBRzLdXZeBegbzTLDV/H
         texac7hqdq1T5fHzrMMX6qMHi5xBgPVNMkm5Yr5/N2T+lE36cw6MwqgHx4ujBn3c+oze
         CZl48S3kFg86mlEE1v5FK1GRcYd/f+/xhpBxnhuU3M2/cAGzmegra0L2KfWTt+IzE6xb
         BGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777641392; x=1778246192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSUUEhTxPVnTNICfoGoDgRMvs6IfWcbouR7fQZ1ACRQ=;
        b=U9TYANaJPQq5ogk+n3Y6kWuMklO3tv/t7dkt/3+kAfLv4j2vDXclwOGSmJ3TlZwQfK
         EJk+8Kv4iSexhwKk5GmVIKO2WV+oXhtu6ZifWq5UIaQ0LTm8+Ta70rvEvTY5V0XpDt2c
         QFFrdxu7BIzku1G8RflOIkT/BvbfINykoTnyiZOxznYZpumOW16wYELA9lncl+Wqlvbc
         0I+dVfb+46ueI418ZAdYdvc6oN4kJrMFV7Pft4/tbUQxexsPso6enCTAIZkf+TMkTSKM
         hqG36DsVSQGYrQ/GitVWeQNEGkhQwPBSVTVQbHksuI/PwJXwF/epTqIz8Ur4BSVKQ1cH
         7meQ==
X-Gm-Message-State: AOJu0YypoM56efO6xXcCnU4sYKFFEAx5HqLwSRfDm/LwGYYzddOQja0v
	O83XQjzjXMxVY5fNjAIWmI83zjGsB+7SJAqaLuOe/hBVY23RWiLlxNQ1WnerFw==
X-Gm-Gg: AeBDieuB1kcPe2XRS/iD2CxagQ1XEOsKgC3BMdyE/gxTZ+73X93WKwzJ/HLANcz20Gc
	Bmd9O5bC9ven1X2MMVlWQoiF9yHQy5oS2P3JYbhOCcRo6Jx5JkKoB892+N6IUbYc8Baqik42Mql
	5Sjjecaa+4RiUrWC/EqjhAQXIujezy4e2eJ40LoH4BBwknisxN83ptg7IhW/niYm7OyxXY6Hynq
	dwwtUdBQlVtJtOoxQy7Rr/sIzkUYYUT3eEoJ5BgWomiXDUfxjq6CvwpqfepvOHteLIZaqBgSXuR
	ydZSzXgpL2bWTyKIx7MC9bxJVoLYyCOo4jcXURhXZuRoQpKRDlPlh5GRuD58dD42+G9SGaTGp9M
	vOYKX7MnnvZAfJgSp56NGtkR034re6S4Yk1yV/vL28mbDd8ph+MjcLnVtRPmjU2ltVmWUL74VqB
	09jS2vh7/OeAstkjjKuU8WeCTwtayP9DLbvKCLKVzxdAp1vBZKg/cbTHHDCG8IeW0=
X-Received: by 2002:a17:902:db0e:b0:2b4:5cea:f618 with SMTP id d9443c01a7336-2b9d36d7eb8mr34519585ad.3.1777641391704;
        Fri, 01 May 2026 06:16:31 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:57df:16f5:b7ab:5d05])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae59f62sm22438005ad.70.2026.05.01.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:16:31 -0700 (PDT)
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
Subject: [PATCH 1/2] sched_ext: Normalize exit dump header to "on CPU N"
Date: Fri,  1 May 2026 21:14:56 +0800
Message-ID: <20260501131521.161852-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260501131521.161852-1-yphbchou0911@gmail.com>
References: <20260501131521.161852-1-yphbchou0911@gmail.com>
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

