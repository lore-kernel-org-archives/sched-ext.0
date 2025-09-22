Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673312CD8B;
	Mon, 22 Sep 2025 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504769; cv=none; b=siYkRt9QuG8eC82CAOTjThIsua5ieLYHo88Yp3uJLxz+Or4+B+tliDuqU6U1+KemXEsczHPLbc5Uej1zyQF+KS76+zqKXuHGq/X8OfkLrOBK7k1DKBVQgy4w2/Xyz3lT7Z0RofLIOxLDO7DIuiifw8MyeiBWE1FVPkDjRCp6FdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504769; c=relaxed/simple;
	bh=VHLLYGUKKLWWYFzSTAhsDh5Dm2/CPftRfbREaFPtaBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmoGgX/xydeZ6pV/G/VckQW3gxd08wFrTJ0rd/oI2QXXU1oyRNtoK97gt6jHIx8PVjKRRK6ltdgX7NCoIqSzssrTLKoBOF96TnP2WbZkW6B7IjcqtR0wk32i7e2rYRStZa3NshqAeZvjjSpZ4wYE+oIHbpUm7fbQYVL/S1NCI3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F88ycVST; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F88ycVST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5B4C4CEE7;
	Mon, 22 Sep 2025 01:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758504768;
	bh=VHLLYGUKKLWWYFzSTAhsDh5Dm2/CPftRfbREaFPtaBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F88ycVSTV6Movs6Cr6llGeJ43JEaYj/ZsCTx/9LXoSkSWaAD7zQNenxB4fLUtB7zl
	 TxImkoNDaPfqFLNtTYA8KPTvuvzvP+CUNEIKFRqSLihUKnczqb/ZSdK/+HS6RJbCaI
	 ORGmpCqE+fMDf1RHlBjkrpGYtP9DtBj/a8aSjZeDS/zgT9agmz31kezz0qz023+6oN
	 S3C+WqJCfd38PsaHIti/eIxdCEBt5/2tigkQ8G0mcndeefHKTrD6BRrYjXqGnm7Teq
	 0pNAxTrbec5c2vrhPA8FmFh8L+eGioOyhXxDMpICJOEOokYQ5Oxy+ApcKC34RHXJ7W
	 OiH+r7WZhuBZQ==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/7] sched_ext: Improve SCX_KF_DISPATCH comment
Date: Sun, 21 Sep 2025 15:32:41 -1000
Message-ID: <20250922013246.275031-2-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922013246.275031-1-tj@kernel.org>
References: <20250922013246.275031-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for SCX_KF_DISPATCH was incomplete and didn't explain that
ops.dispatch() may temporarily release the rq lock, allowing ENQUEUE and
SELECT_CPU operations to be nested inside DISPATCH contexts.

Update the comment to clarify this nesting behavior and provide better
context for when these operations can occur within dispatch.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 7047101dbf58..d82b7a9b0658 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -108,7 +108,11 @@ enum scx_kf_mask {
 	SCX_KF_UNLOCKED		= 0,	  /* sleepable and not rq locked */
 	/* ENQUEUE and DISPATCH may be nested inside CPU_RELEASE */
 	SCX_KF_CPU_RELEASE	= 1 << 0, /* ops.cpu_release() */
-	/* ops.dequeue (in REST) may be nested inside DISPATCH */
+	/*
+	 * ops.dispatch() may release rq lock temporarily and thus ENQUEUE and
+	 * SELECT_CPU may be nested inside. ops.dequeue (in REST) may also be
+	 * nested inside DISPATCH.
+	 */
 	SCX_KF_DISPATCH		= 1 << 1, /* ops.dispatch() */
 	SCX_KF_ENQUEUE		= 1 << 2, /* ops.enqueue() and ops.select_cpu() */
 	SCX_KF_SELECT_CPU	= 1 << 3, /* ops.select_cpu() */
-- 
2.51.0

