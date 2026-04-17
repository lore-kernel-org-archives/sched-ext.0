Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FDE33ADB5
	for <sched-ext@lists.linux.dev>; Fri, 17 Apr 2026 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776417537; cv=none; b=fLr9Ekk9apv9R7BwRT1SZYaUJel0HNg9PqPW6h+IpW6Yrlny92C6Gjfs3e0dF4h48mz3PY0TRzmY5Xjiv+dwAUmgoXwqYrMd99U8suoq5aDflBDRszUZREJ9s8/TYnVGtt5KwcsjSvRdmCVnBd7vxZD1bR7LSlM+hrL1j8KXxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776417537; c=relaxed/simple;
	bh=6qjBlBmyp/PINmyVZMMTVO+ArByObsurx16vbZ9a8J4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q0P+jxOHD159RnXlXPcDExTRs6KpuLYl85hwMLwAFEEFqyNVC5837hMYNFOIgE3PtGS8r9Wur3/GDNVvBhJxC+4BoORAfN6r+kZVXz1PcS7AyUYqAK/4J12XdFiRlUtSc1oxT6o7r2yNPJrVygHN7dGRAo6tdkC7thmpQ/wn8Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=d64d6Qcv; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="d64d6Qcv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type:To; bh=2YWo1haEQOT/EyqLu1ard4PB68jWMf6E85JIffT6+RE=;
	b=d64d6QcvXHmYWSX/utWEYLovNYX2mlou0NWVQzY+3JgzFXkMExkAOLV607FBkM
	4VvNiovS0Ddwv+a29JXwUuL0IInNF/G2QgqFCvQiHAMdbZQP4oINxZbgTGONFznB
	4aDkBMzVeVMC+MMvA5mzN4hNcsg2KdHV7k9UX5Df2s+bg=
Received: from [127.0.1.1] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3l+jY+uFpMSmcBg--.7149S2;
	Fri, 17 Apr 2026 17:18:17 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
Subject: [PATCH v3 0/2] sched_ext: Cgroup sub-scheduler minor fixes
Date: Fri, 17 Apr 2026 17:18:01 +0800
Message-Id: <20260417-sched_ext-0417-v3-0-e11b3aed57d3@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMn64WkC/yXMQQqEMAxA0atI1ha0Dg71KiLSpnGMC5VGpSDef
 aou3+L/E4QCk0CTnRDoYOFlTqjyDHC0848U+2TQha6LT/lVgiP5nuKmHjp0WHljtDUWUrQGGjg
 +w7Z7LbubCLf7Atf1B7vSmVxyAAAA
X-Change-ID: 20260417-sched_ext-0417-bcbc3d992a9a
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Zhao Mengmeng <zhaomengmeng@kylinos.cn>, 
 Cheng-Yang Chou <yphbchou0911@gmail.com>
X-Mailer: b4 0.15.2
X-CM-TRANSID:_____wD3l+jY+uFpMSmcBg--.7149S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry7Kw1fWF4xAw17uF18Grg_yoWfCFg_Za
	45CFyDtFyUZFs3Xa4aqrs8XryrGa1UXF95G3WDKryDCr9rAr1DKr4UJay5ZF10qay3WF1f
	X3yFvFWrJwn3KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjq2MUUUUUU==
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqxnHP2nh+tky4AAA3z

This patchset contains two fixes that I met when testing cgroup
sub-scheduler. Patch 1 add the -c option to scx_qmap help, which support
sub-scheduler but has no clue how to use it. Patch 2 add logs when sub-
scheduler is disabled, almost the same logic as root scheduler.

V3:
- Commit msg nit fix (Cheng-Yang Chou)
- Rebase on sched_ext/for_next(1d2c5353152d)

V2:
- Add [-c CG_PATH] to the usage synopsis(Cheng-Yang Chou)

---
Zhao Mengmeng (2):
      tools/sched_ext: Add missing -c option in scx_qmap help
      sched_ext: Print sub-scheduler disabled log and reason

 kernel/sched/ext.c         | 39 ++++++++++++++++++++++++---------------
 tools/sched_ext/scx_qmap.c |  4 +++-
 2 files changed, 27 insertions(+), 16 deletions(-)
---
base-commit: 1d2c5353152d2e937a24b08261591c198996d13d
change-id: 20260417-sched_ext-0417-bcbc3d992a9a

Best regards,
--  
Zhao Mengmeng <zhaomengmeng@kylinos.cn>

