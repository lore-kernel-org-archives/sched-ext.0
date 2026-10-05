Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA5B4D6C53;
	Mon,  5 Oct 2026 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222925; cv=none; b=JoeAc5RfsxFjembaBJTzaANopcPpLof5FoQC0+sEY6oOLjwr8EM9OFQwoAv1c4RKc4MzEiskZwFs7GVDBAxm7cmEHDyjQcKpN0fOGgrr7zUY9yGrFgZaLpO38p/kGoTiwgsJtF34mFIJrfIS3R91sPmP6d8krGJH03Lfqc7k/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222925; c=relaxed/simple;
	bh=7y10vNUyXTpP7o+Htn04kq5oKuc7Wz020kXl5rTbL9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leugEVAdhd69rgWDOtfymEQv1jmhzcoarCpnG59pgEnZtDY4E+ozvvUktNNT7eXPIbs/P/aRPLjCOLI7Fud6MpLpCD/6q5h1t1rVVTlbZil9wvGa55fmG7LjYZgYOWrORNBsd6v1VbR4hNMHYNr/YywmCkMyiVYfFmYAL0QCx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXqJj5H4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXqJj5H4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E491F00893;
	Mon,  5 Oct 2026 17:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791222923;
	bh=pM4LeV9DUnZ4fONPyziYdZlv14H+p66wY3yKou2smkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kXqJj5H4ONH/hxp63VxsImkpxsfCETjhK5GuDvBm76zZ3ItJBtD1Z0JljAiVjK4WR
	 C0s/tPYpNyCXR55gqfyCtUu3rWrk0VnINGATAFVIvLtjw4dBxeVljtulcnov8Cy3IY
	 8ByjbCWZXRgmOOd8PpOOE/bbCFP3AOVvVreMTxUJ67pSCFMa+txK3vmV1pZKJv4S7p
	 qyCbBPP1MX67WJEZ7A/iyq9iUngWj6FPb4q6fv4EyPNvj7KI2/iBgjX8yGW/Z5E+o9
	 0l5Ii2EYnKMyPTC+3yrid1qm/FmfGOB+oaLfg60C0j0Umf/rMjrhnwaz272LSPvEi3
	 rkv7K3nHzHD8g==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/3] sched_ext: scx_qmap: Size the cid range buffer for large machines
Date: Mon,  5 Oct 2026 07:55:19 -1000
Message-ID: <20261005175520.2756986-3-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005175520.2756986-1-tj@kernel.org>
References: <20261005175520.2756986-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hier rows' cid range buffer holds 128 characters. When no two
consecutive cids share an owner, which SMT siblings numbered far apart
produce, every cid prints on its own and the list is cut off with "...".
Size the buffer for that worst case at the build's cpu cap, off the stack.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/scx_qmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index d5226e071657..96e485c9e877 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -162,7 +162,9 @@ static void format_cid_ranges(struct qmap_arena *qa, s32 owner, char *buf, size_
 /* partition summary + one row per sched: weight, cpus, dispatch rate, cids */
 static void print_hier(struct qmap_arena *qa, struct hier_prev *prev, u64 own_cgid)
 {
-	char ranges[128], who[16];
+	/* worst case, no ranges: a comma and up to six digits per cid */
+	static char ranges[SCX_QMAP_MAX_CPUS * 7];
+	char who[16];
 	const char *rr = "-";
 	double secs;
 	u32 i;
-- 
2.55.0

