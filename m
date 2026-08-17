Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4643D50C;
	Mon, 17 Aug 2026 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977102; cv=none; b=flfRDITRul4m5D9J7IR9Vryvzp7IqZWDKmM0SexRMDMbNgrYmOIbrBywsRhaogPJb7SLqtVf9YHpYj/I6gaep4L2VVGa+iwiqBVCHzDHrAweboFq6qv6ZLPayMkQwLHKxsWdpW0qbNxUV5bv6jhNh6gV/TahomAQgV5IcXWoY/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977102; c=relaxed/simple;
	bh=I8SacstheWiav0quJotXowXeTtjVHp3/vWs0mUXXt/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aEvxfrz9IaI5C5+bgqLFOPtu60VrbjGEAxhmutDKaoJtLkkwxIDEOb0J1eQsOZw245a95Egd+rm1lK9viV/PBssUHSCB5RNc4lq+LZ5KwbCBIq1UpzQDGmqT4FAuEfe1F/DJizYXoCE9u/q40BRyE02B2UeqoUuUc+S4Q2B7DRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AKLIsEwH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AKLIsEwH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=R97/9/9h+QOZ1ZDTziXsiVt+tfFq4+nBsBN5jrDnuLA=; b=
	AKLIsEwHdKLogXzxT756RdqqGKgi2yZB64Lh2MtlLuxmJGe2qG9HkVNjxItZDXhtJ9GoHm2zswzH6
	S1vBSYnhqFLYRjrFP6txoUqUJRAnBETVhOirJcR7ceqWvJgqsjN4ZzZEGWLQ+ry+I7JfJTljEEtFz
	YvcnRpDkwd8TYktEI9dAoRgKeTGINiGH3J18FXRx7U9nO7nN/fWJPTQ9UUMCcQwIwHGAzQcmRZvMV
	rXpQU4uYokMr/v0yKwl4cxAS6vxh6768nZ2UkdSyra6JvYWXleUlA5snZ2kqpBXYSjU0XU0I9qeQy
	z8JTvrUTSD11XSNq59IPNfLEuY6fnRH4KA==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wvyNA-004ZxV-S1; Mon, 17 Aug 2026 16:31:33 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: gavinguo@igalia.com,
	kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] sched_ext: sync compat.bpf.h peek/reenqueue fixes from sched-ext/scx
Date: Mon, 17 Aug 2026 23:31:24 +0900
Message-ID: <20260817143126.562923-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two fixes landed first in the sched-ext/scx tree [1], which carries
the reference scx/compat.bpf.h. This series syncs them into the kernel
tree's tools/sched_ext/include/scx/compat.bpf.h.

Patch 1 gates the lockless scx_bpf_dsq_peek() behind kernel >= 7.1.0,
where its stale task-pointer bug is fixed (2f2ea7709266, 71d7847cad44);
older kernels fall back to bpf_iter_scx_dsq.

Patch 2 adds scx_bpf_reenqueue_local_from_anywhere() and prefers the
generic scx_bpf_dsq_reenq() kfunc, giving arbitrary-context callers a
supported entry point (-ENOTSUP when unavailable).

[1] https://github.com/sched-ext/scx

Changwoo Min (1):
  compat.bpf.h: add scx_bpf_reenqueue_local_from_anywhere() compat
    helper

Gavin Guo (1):
  compat.bpf.h: Gate scx_bpf_dsq_peek kfunc behind kernel version 7.1.0

 tools/sched_ext/include/scx/compat.bpf.h | 48 ++++++++++++++++++------
 1 file changed, 37 insertions(+), 11 deletions(-)


base-commit: e5a0a3d6b05a62a2921698a60f2c84ea3da97d51
-- 
2.55.0

