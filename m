Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814E3CC7EC;
	Sun, 17 May 2026 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042976; cv=none; b=J40T02e/DLd81ZyYs6r+HIpKq/vQSIuzYzads+URlB/J5eS74HSJXx10GjqSTan6EdLt+l90aJxPiNL7KMAigDRiAw8wwmPW2rOaC9OmEl8tTDNbdH89VhGGP+to45KyRGqpRmoAhsNf/AZpG/LP5d8Kyf9FjppMTpqNvvImDgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042976; c=relaxed/simple;
	bh=tgVmokPTzZmWe87zVMvyByUvdQz/DK2l370kpo10d1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SnLhAg4IMSsqsnX7+tt1E2HguvaVZDcSCKRy/NBCe2OTsd3X7NdAIN5R2bipSt3G7/wYvC///9G+3obW4IuW4yFG5UNRjIQyGXkMIeg2VLpBMVxDrUhqLWKboLzCx6QTjSdci1OejMSm4R0nXlkcWUQsgo9sQf8Ub5qJACttL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rds4Uxaq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rds4Uxaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE761C2BCB0;
	Sun, 17 May 2026 18:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779042975;
	bh=tgVmokPTzZmWe87zVMvyByUvdQz/DK2l370kpo10d1I=;
	h=From:To:Cc:Subject:Date:From;
	b=Rds4UxaqKmx2zhDhg8VIv7j+gvZk+3BZD9Oi1CSoGTx3zqRUC0vKAPd4eB7w5p/2W
	 2VZrgvJiDYQAxJWdF95pl0liSgz963+WYGlykFT3FlC4/1cjiDxVC4PgMCthfgomAW
	 YXmPNmcT3T5zlbvIkYV95uacVjNBPI9k1A8HQvwklM84Tg43ze08l3AvRx/sew3Azt
	 r/W4a4x2+Ny7zrj0cAaHAna/pT9rzja1poM9ICebsV5WmF9ZQSn2Tkp0C6zogI9AhK
	 E0l08gw7OCKaaQTbjXYZIUccBcohY1Q1Ih1kasCRQgbI0uAJdeenhA8Om5oJamTOhM
	 uGzu2iQh9FHaw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET RESEND sched_ext/for-7.2] sched_ext: cmask improvements
Date: Sun, 17 May 2026 08:36:11 -1000
Message-ID: <20260517183614.1191534-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Resend with the correct cover letter. The earlier posting
(20260517181022.1184056-1-tj@kernel.org) went out under a stale cover
from an unrelated draft; the three patches themselves were the right
ones and are unchanged in this resend. Apologies for the noise.

Three patches for cmask: tidy active-range bookkeeping and add the
mask-on-mask op helpers the sub-sched series will use.

Not backward-compat with the current scx_cmask layout/API, but cmask
landed in for-7.2 and hasn't been released; scx_qmap is the only user.

 0001 - sched_ext: Rename scx_cmask.nr_bits to nr_cids
 0002 - sched_ext: Track bits[] storage size in struct scx_cmask
 0003 - sched_ext: Add cmask mask ops

Based on sched_ext/for-7.2 (c9017d335aab).

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git cmask-prep

 kernel/sched/ext_cid.c                | 307 +++++++++++++++++++++++++++++++++-
 kernel/sched/ext_cid.h                |  71 +++++++-
 kernel/sched/ext_types.h              |  64 +++++--
 tools/sched_ext/include/scx/cid.bpf.h | 117 +++++++++----
 4 files changed, 506 insertions(+), 53 deletions(-)

Thanks.

--
tejun
