Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C817BA2
	for <sched-ext@lists.linux.dev>; Fri, 26 Dec 2025 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766738857; cv=none; b=tuocHpLugEJmrNjyRuQZ8bDtwSzmd4Skmi/vtjg7dSSECAdjuMDAv+Zfoh2DW7LHGOR+xpg2+A82AUonej04Z5ZBT2TpNR6tYmGofVScKE/CPpW9L699S/LEM+5RqGCJw1FVEB0nA4ZAOfruOOenHDWrBHw+XzwwgonPhaPQUF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766738857; c=relaxed/simple;
	bh=flInGbUmBzenFR7+Vanm6gHg578lco6a7iPI21UuD0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROz16XqDwjUpZFftDHn0u6Z4yXr8dW8DzJXa/bLabPUDkHINdOHxFEoJWu9BN8ElAaUpRvRCrYICSzpT/nPnhKvJD73PuILmKlINSXJdoGf9jbWhCId3CRIYojs3xx6pHsgkRug+RMVnFn3wFPvj7l+nKyIzvGWJIM9h5N47Nt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qz3DdPX2; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qz3DdPX2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1766738855; x=1798274855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IJTJnxhs03I/7UadT/lLPI9i4JHWyKnCiePautfQ9qg=;
  b=qz3DdPX2F4N1/gzNtuh6jlMaPymCWPdI4DNEEPOP0vZTOW2Bur0yyDgt
   ABLyNHdw/tsrKdxTs9E2EwQGrlWg54XSmiUGlegC3OPzGUA/g7bAroQh0
   fNAd9m61pGQSpcORNNXdrdr95lYtHSzfspBlEZuez/rsv1nI4xYnFd1B6
   Mc9TQgC9aeug9APG9dXm1JmdTdcBcvubfIexenOc1+O5K8aFsRxaTLMqA
   AjUiBbQyjq7ksHQhzv8WMaLj5gCt4u45jgVHGpK92UJN1ty3D0Cp3Fz08
   knG27FH45/6yy5G65lnVTzQGSL4JfOyKCEgLfGV7uQXdbu+P5LP8/2RTu
   g==;
X-CSE-ConnectionGUID: cHgiZrGtQsibCF5VOAQGRQ==
X-CSE-MsgGUID: i99lMObeSSyM/Pg49Fei+Q==
X-IronPort-AV: E=Sophos;i="6.21,177,1763424000"; 
   d="scan'208";a="9661614"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 08:47:33 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:29939]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.64:2525] with esmtp (Farcaster)
 id 05e92b78-442f-4c72-a9dd-c47edfc7e4d1; Fri, 26 Dec 2025 08:47:33 +0000 (UTC)
X-Farcaster-Flow-ID: 05e92b78-442f-4c72-a9dd-c47edfc7e4d1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 26 Dec 2025 08:47:32 +0000
Received: from localhost.localdomain (10.37.244.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 26 Dec 2025 08:47:31 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <sched-ext@lists.linux.dev>
CC: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi
	<arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Kohei Enju
	<enjuk@amazon.com>, Emil Tsalapatis <emil@etsalapatis.com>, Dan Schatzberg
	<schatzberg.dan@gmail.com>, <kohei@enjuk.jp>
Subject: [PATCH v1 1/2] tools/sched_ext: fix scx_show_state.py for scx_root change
Date: Fri, 26 Dec 2025 17:46:49 +0900
Message-ID: <20251226084657.75567-2-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251226084657.75567-1-enjuk@amazon.com>
References: <20251226084657.75567-1-enjuk@amazon.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Commit 48e126777386 ("sched_ext: Introduce scx_sched") introduced
scx_root and removed scx_ops, causing scx_show_state.py to fail when
searching for the 'scx_ops' object. [1]

Fix by using 'scx_root' instead, with NULL pointer handling.

[1]
 # drgn -s vmlinux ./tools/sched_ext/scx_show_state.py
 Traceback (most recent call last):
   File "/root/.venv/bin/drgn", line 8, in <module>
     sys.exit(_main())
              ~~~~~^^
   File "/root/.venv/lib64/python3.14/site-packages/drgn/cli.py", line 625, in _main
     runpy.run_path(
     ~~~~~~~~~~~~~~^
         script_path, init_globals={"prog": prog}, run_name="__main__"
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     )
     ^
   File "<frozen runpy>", line 287, in run_path
   File "<frozen runpy>", line 98, in _run_module_code
   File "<frozen runpy>", line 88, in _run_code
   File "./tools/sched_ext/scx_show_state.py", line 30, in <module>
     ops = prog['scx_ops']
           ~~~~^^^^^^^^^^^
 _drgn.ObjectNotFoundError: could not find 'scx_ops'

Fixes: 48e126777386 ("sched_ext: Introduce scx_sched")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 tools/sched_ext/scx_show_state.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_show_state.py b/tools/sched_ext/scx_show_state.py
index 7cdcc6729ea4..aec4a4498140 100644
--- a/tools/sched_ext/scx_show_state.py
+++ b/tools/sched_ext/scx_show_state.py
@@ -27,10 +27,13 @@ def read_static_key(name):
 def state_str(state):
     return prog['scx_enable_state_str'][state].string_().decode()
 
-ops = prog['scx_ops']
+root = prog['scx_root']
 enable_state = read_atomic("scx_enable_state_var")
 
-print(f'ops           : {ops.name.string_().decode()}')
+if root:
+    print(f'ops           : {root.ops.name.string_().decode()}')
+else:
+    print('ops           : ')
 print(f'enabled       : {read_static_key("__scx_enabled")}')
 print(f'switching_all : {read_int("scx_switching_all")}')
 print(f'switched_all  : {read_static_key("__scx_switched_all")}')
-- 
2.51.0

