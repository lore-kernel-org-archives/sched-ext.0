Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED93A382D;
	Wed, 29 Apr 2026 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451021; cv=none; b=uJKfbcZIkEAGyzmsCA8bhk4rQrzo8C7UfxCN2H10aDfWvVtMiduCcHpTz2MrQIcxN722U0Ig0lSnBb6DJJGponCUlAp6gI0CFGQtMzMRhvsDZwBSMZDDmIjCHDEZP/WOwPYeb6Z7Kf7onFGCHleGkQkaEY+9hMM6A+EW94rvd2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451021; c=relaxed/simple;
	bh=y4AkeUxsi8GWC+hsdHSg5m3W2Xo5Sgl4s7cSwD930Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eiYLu8q5n/Ws5uy0QpgYDuqvUTWY08+3DdxOJSmFO/EjswepqHfIZF8eFdaFJT8FQ/9UsulFjiyJFeaEH8TmTegPMYyxP1dHzgSldeRUl+jGXdy4H6+BgfGCi4cJTV+z/3MP+PTBGJfBXIS7mnsSBTBJ7584lkHkhp2cowOMsIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=K6SDohUK; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K6SDohUK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=C+6DgCj31KLYgWCl4frGR2tJj+Q14oDXnpc13dnB5Hc=; b=K6SDohUKhloCa/bgL8YEZYrSEM
	w3zh6V0NAfd4LRAGqHpaYTUQqach+m7cpdePF3kNC5xyfSOgL0AUbRFMKJ5ti57Bp4I0DDNUWBrfx
	WBvUwuAU4vtyAQw4cMTkHdX+3xDrMcEJ+8zsHuuwsk1tm7N613xMrit0bEfitqt1gTXeRDfhpq1Pp
	1pgw49CgITNTVm+idN4sgFSdSOYYa0Sj4dwunWhwg21VyLUhEjuK5daiAnEQXfUhT9fQOKOj/kUtO
	lGRdetbcx8yzhEbVnru0hHDd8OqOkHDL0KztyH+EM2fpl0OIwESdvUxG0d530vYiIIIjM1/lP15GA
	ftiJxfTw==;
Received: from [58.29.145.179] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wI0Ce-003oio-Sh; Wed, 29 Apr 2026 10:23:28 +0200
From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: kernel-dev@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] sched_ext: Improve exit-time diagnostics
Date: Wed, 29 Apr 2026 17:23:15 +0900
Message-ID: <20260429082318.420146-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sched_ext is disabled by an error, the per-CPU state dump in the
exit info can get truncated on systems with many CPUs. If the CPU that
triggered the exit happens to be in the middle or end of the CPU list,
its state may never appear in the output, making it difficult to
diagnose the failure.

This series addresses that by always dumping the exit CPU first and
surfacing the same CPU id to BPF schedulers and userspace tools.

Patch 1 is a preparatory refactor that extracts the per-CPU dump logic
into a scx_dump_cpu() helper.

Patch 2 adds an exit_cpu field to scx_exit_info and threads it through
the exit path. The scx_exit() wrapper is reworked into a macro that
captures the calling CPU automatically for all error paths, while the
watchdog stall site records cpu_of(rq) explicitly. scx_dump_state()
reports the CPU in the dump header and emits it before the rest of the
per-CPU loop so it survives any output truncation.

Patch 3 propagates exit_cpu to struct user_exit_info, the BPF /
userspace shared exit record. UEI_RECORD() defaults the field to -1
before its CO-RE-gated copy so older kernels remain distinguishable
from "exit happened on CPU 0", and UEI_REPORT() appends "on CPU N" to
the EXIT line so scheduler authors see the most diagnostically useful
piece of exit info without cracking open the debug dump.

Changes since v2:
- Use s32 (instead of int) for the new exit_cpu field and the
  __scx_exit() / scx_vexit() parameter, matching the convention for
  CPU ids in sched_ext.
- v2: https://lore.kernel.org/sched-ext/20260429060726.359024-1-changwoo@igalia.com/

Changes since v1:
- Generalized "stall CPU" to "exit CPU"; the scx_exit_info field is
  now exit_cpu and is populated for any path through scx_exit() /
  __scx_exit() / scx_vexit(), not just the watchdog stall path.
- Added patch 3 to expose exit_cpu via struct user_exit_info.
- SysRq-D initializes exit_cpu to -1 so debug dumps not tied to an
  exit don't arbitrarily promote CPU 0.
- Dump header now reports "on cpu N" alongside the exit kind.
- v1: https://lore.kernel.org/sched-ext/20260408031113.76005-1-changwoo@igalia.com/

Changwoo Min (3):
  sched_ext: Extract scx_dump_cpu() from scx_dump_state()
  sched_ext: Dump the exit CPU first
  sched_ext: Expose exit_cpu to BPF and userspace

 kernel/sched/ext.c                            | 221 ++++++++++--------
 kernel/sched/ext_internal.h                   |   6 +
 .../include/scx/user_exit_info.bpf.h          |   3 +
 tools/sched_ext/include/scx/user_exit_info.h  |   2 +
 .../include/scx/user_exit_info_common.h       |   5 +
 5 files changed, 142 insertions(+), 95 deletions(-)

-- 
2.54.0

