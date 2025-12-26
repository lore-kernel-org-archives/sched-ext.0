Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E540CA945
	for <sched-ext@lists.linux.dev>; Fri, 26 Dec 2025 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766738881; cv=none; b=SvrcV5uao4B0pGqM1416e/P7d+jtx38wGVWWh8fSLJc3GVipacD0iB93H+I3CIfYWcdaRgwK1bBveNHD1vU0p5nz4MSuYt1Bhcw0+8E5D2xK+TV8yE98b3Krn/le+NHuthWrpUrnhAGhznzJXu7+MQ5DlqB/uzQg97iiV2OunOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766738881; c=relaxed/simple;
	bh=SwGod/byTgy0MCbp/QdQQ7i1mrFPBo8DMe6ZfpXa+p4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E6HWKgdr6r4nH3Ky/QBEgcxLvEJXY+9HqhQ4AV25rjArmT+GqV0fSMuiinf0kOJbMQ6EyvW+fg50HE6Ksqlu3B6TYBjm67zEsDgQVIZ1OAaO/5+gOk8ExZCEALXOikKIQU+u6RW3DUcYnYWzHbvdF5ePZChwJXdhkyCVUbCi16g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=afdciadd; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="afdciadd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1766738879; x=1798274879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SSyCQqLvAjN/uD8eUc4VpoVkL0rJOXKjnaxHAo5jp+8=;
  b=afdciaddyEOe+4jYMLhPqOnEC4cb/0k1rxPmRJaTP37Pyw8FknkN4lC0
   rqN3kWB/9iawaeENUc8PopdGlGRbioBMkq5GEBFLFIOnNgSOlO1Jq+wb2
   6VhPaaRtnIcjk3mn0Mh5aCFQT+pWQ7qc6k6j5mx2NWW+R9JcZNf7fxCj0
   j7Lvm7810uZtsLyN/WvOzF+iMut+6xqNyaW2ZvUZAqZBNE/6YaAujLvCh
   PDJU793UtS8mc2he/71U3BZbY5ZsfkoqfUvjnCcr/yTkZZI/QHM9kVXsi
   S10WkRyUFpzp1mDmR/USYOzrvaC+7tltm60jsOn07TrK2T6KDMScHaXcB
   g==;
X-CSE-ConnectionGUID: Fk3IWhvqTIuVaHe7TxDBJQ==
X-CSE-MsgGUID: 2r5XzShmQ1ykKn7hhELKLQ==
X-IronPort-AV: E=Sophos;i="6.21,177,1763424000"; 
   d="scan'208";a="9557065"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 08:47:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:28831]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.166:2525] with esmtp (Farcaster)
 id 457e06ba-4da8-4145-8483-149fcb17cb2e; Fri, 26 Dec 2025 08:47:57 +0000 (UTC)
X-Farcaster-Flow-ID: 457e06ba-4da8-4145-8483-149fcb17cb2e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 26 Dec 2025 08:47:56 +0000
Received: from localhost.localdomain (10.37.244.7) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 26 Dec 2025 08:47:55 +0000
From: Kohei Enju <enjuk@amazon.com>
To: <sched-ext@lists.linux.dev>
CC: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi
	<arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Kohei Enju
	<enjuk@amazon.com>, Emil Tsalapatis <emil@etsalapatis.com>, Dan Schatzberg
	<schatzberg.dan@gmail.com>, <kohei@enjuk.jp>
Subject: [PATCH v1 2/2] tools/sched_ext: update scx_show_state.py for scx_aborting change
Date: Fri, 26 Dec 2025 17:46:50 +0900
Message-ID: <20251226084657.75567-3-enjuk@amazon.com>
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
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Commit a69040ed57f5 ("sched_ext: Simplify breather mechanism with
scx_aborting flag") removed scx_in_softlockup and scx_breather_depth,
replacing them with scx_aborting.

Update the script accordingly.

Fixes: a69040ed57f5 ("sched_ext: Simplify breather mechanism with scx_aborting flag")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 tools/sched_ext/scx_show_state.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/sched_ext/scx_show_state.py b/tools/sched_ext/scx_show_state.py
index aec4a4498140..02e43c184d43 100644
--- a/tools/sched_ext/scx_show_state.py
+++ b/tools/sched_ext/scx_show_state.py
@@ -38,8 +38,7 @@ print(f'enabled       : {read_static_key("__scx_enabled")}')
 print(f'switching_all : {read_int("scx_switching_all")}')
 print(f'switched_all  : {read_static_key("__scx_switched_all")}')
 print(f'enable_state  : {state_str(enable_state)} ({enable_state})')
-print(f'in_softlockup : {prog["scx_in_softlockup"].value_()}')
-print(f'breather_depth: {read_atomic("scx_breather_depth")}')
+print(f'aborting      : {prog["scx_aborting"].value_()}')
 print(f'bypass_depth  : {prog["scx_bypass_depth"].value_()}')
 print(f'nr_rejected   : {read_atomic("scx_nr_rejected")}')
 print(f'enable_seq    : {read_atomic("scx_enable_seq")}')
-- 
2.51.0

