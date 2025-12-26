Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8017BA2
	for <sched-ext@lists.linux.dev>; Fri, 26 Dec 2025 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766738833; cv=none; b=oK9iFlWKECyu5KRBh0OYsbORMKVfjrjEF5oeUI/QU2mwUbBx4xscPUB1oGnENV2LArCvZInoCpuSZ+VZpPl34u8NQ5tSL570xkQhYCsCD7CCXY598QVg/gAOTYn74nw23WoBTMe4B/nWtRySEWKklJN7i9VJW4owZrRnvtAPmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766738833; c=relaxed/simple;
	bh=eeksswpX+cZxnC17bUKN7GNUBgriCePvixjJzveURjw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aB7MWrO7fud4QRD1fA60zYpWCsdnZTnZAJtozjlZ4eoydDs1rRV7O2AwMvYwBXoMUduEvLAy7CJUScwtxSnYJBCWTajBAaOeznfa6c0/M96Qh23hNjk0GYHgYgCgscuFEOFWT9kGFOHcuPdOb16+xvU46GNEyJtpAHrEKJ3zNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=qo3eE9rS; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="qo3eE9rS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1766738831; x=1798274831;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NLE0+ManJEJ7faRl2PxvYd5k4pMSahBLHzmroEnCur0=;
  b=qo3eE9rSb5s+CRrT6vRPFi2mUWcx4J53oqJJnRQPS2+skIVKb/c4IN9R
   Ifou3xx9O0VtcxtM5DBptkChFZ7VguDVsNIsWZv1muzgnUJG973IKss2F
   A1Yrzj6iNOEvICadfAYiqBpPDAzF0hMlSl/pLulik2kFcimKp9kes4zVI
   u5uUQBAbtPhvHncNXWXVeO+M2Fz6GnoDuSxogWdXHH5dZJwOsLFySX/l6
   PiMJZqzm2biKnPgSf1KMp8nPibL7v6D/AjhrFhKxbhplTQrkPm3WCFfce
   rNllwHtu8LGCGo6SjhGy3nyx/fj9i8S6KmtXazoj88ffIVoeFrm/TsTsZ
   A==;
X-CSE-ConnectionGUID: sqScfHS0RliRvFHl2QX8Vg==
X-CSE-MsgGUID: 3pXZiJd7Twi8ixumI0NxHg==
X-IronPort-AV: E=Sophos;i="6.21,177,1763424000"; 
   d="scan'208";a="9771030"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 08:47:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:4561]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.166:2525] with esmtp (Farcaster)
 id b10c3eff-fbc8-454c-8496-dae3d1fc1fc1; Fri, 26 Dec 2025 08:47:09 +0000 (UTC)
X-Farcaster-Flow-ID: b10c3eff-fbc8-454c-8496-dae3d1fc1fc1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 26 Dec 2025 08:47:08 +0000
Received: from localhost.localdomain (10.37.244.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 26 Dec 2025 08:47:07 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <sched-ext@lists.linux.dev>
CC: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi
	<arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Kohei Enju
	<enjuk@amazon.com>, Emil Tsalapatis <emil@etsalapatis.com>, Dan Schatzberg
	<schatzberg.dan@gmail.com>, <kohei@enjuk.jp>
Subject: [PATCH v1 0/2] tools/sched_ext: fix issues in scx_show_state.py
Date: Fri, 26 Dec 2025 17:46:48 +0900
Message-ID: <20251226084657.75567-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Due to recent changes in kernel/sched/ext.c,
tools/sched_ext/scx_show_state.py no longer works properly.

Fix these issues:
1. Use 'scx_root' instead of 'scx_ops'
2. Use scx_aborting instead of scx_in_softlockup and scx_breather_depth

Kohei Enju (2):
  tools/sched_ext: fix scx_show_state.py for scx_root change
  tools/sched_ext: update scx_show_state.py for scx_aborting change

 tools/sched_ext/scx_show_state.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.51.0

