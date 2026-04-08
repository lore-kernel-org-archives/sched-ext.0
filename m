Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE6E36CE1B;
	Wed,  8 Apr 2026 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775617899; cv=none; b=dV9AOnH35UY6XC1Uuq3M1d12zbbrsuYRFu7ScraNKFnVCDlpIW/IEHYNgPeExJSrXdzC8UYOJA2Y7W6QNqTJTtoiB2v0nXxbtS1bqMW8snfNHyw4VJhyCVQ/V8LQwtIFw8gHSgCL12bzdTpQgTmjUlNPQdtmYS1wjuBuGi2ZiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775617899; c=relaxed/simple;
	bh=B1tWgEjuz3KZXwwLjxHy5eXx1NPU3fgj7Awk5SfugHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nXZqoTAPoBOWJA8vdIQQ4MV/vX2quIkNt3sDxeHTjZ8/DUGHRoR/YeaWpPXE/35B1F8Y3Y4FL2epgSyzbeBRxP4BH/L1uKEABhuuy4EqdZps/hLzSFBA5IE+HT1ODZYm8SpvuNJB4dGzOMs+8q4V18NNjpEy7sG6/Eo+cEO9Rfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WjoqAnUA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WjoqAnUA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4ufVw0Zm3U/wyVJGFUBwpGBW6jX4QZy5m/HG0FHs7aU=; b=WjoqAnUAJGQ1nCC9WcMCZc4cd+
	Y8bNt8s99UsLHmumbKdYsktk9iCZvJt2dWZQA89bTQ0yuNclH2XBaBcha4eFAbXlz6e4RzY9a0Gvu
	fkmNsY2cO/OFbATh49U+1zo1PXGHGiLYsLElSLrCxmB0Azmjhyknzfdl6C3yFKT8Hndz/s17mf8Mc
	amU5dmfYg+7vhQ/yGDthSs54TS9tW/QWCxykO1siSefXeUTmvTanRFaceqaXwJJENcHWnyomMF9VR
	OelLITW+Ecpym/XKeqDjanDqR050dNffMA8hsG6GTPTANzaRqqr7IPBkKiasaw93TFIlgs+xu45re
	9QfY4VCA==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wAJK6-00DIXo-IA; Wed, 08 Apr 2026 05:11:23 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] sched_ext: Improve watchdog stall diagnostics
Date: Wed,  8 Apr 2026 12:11:11 +0900
Message-ID: <20260408031113.76005-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a watchdog timeout fires on a system with many CPUs, the per-CPU
state dump in the exit info can get truncated. If the stall CPU happens
to be in the middle or end of the CPU list, its state may never appear
in the output, making it difficult to diagnose the hang.

This series addresses that by always dumping the stall CPU first.

Patch 1 is a preparatory refactor that extracts the per-CPU dump logic
into a scx_dump_cpu() helper, making patch 2 straightforward.

Patch 2 adds a stall_cpu field to scx_exit_info, threads it through
the exit path, and reorders the dump loop to emit the stall CPU before
all others.

Changwoo Min (2):
  sched_ext: Extract scx_dump_cpu() from scx_dump_state()
  sched_ext: Dump the stall CPU first in watchdog exit

 kernel/sched/ext.c          | 202 +++++++++++++++++++-----------------
 kernel/sched/ext_internal.h |   3 +
 2 files changed, 112 insertions(+), 93 deletions(-)

-- 
2.53.0

