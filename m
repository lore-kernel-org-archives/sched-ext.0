Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE03054CE;
	Sun,  9 Nov 2025 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762713084; cv=none; b=ca1KG1AFBy32abGC5aegfiDADCqyHtAvVtzvtpEbrM1WSUzGSBImM4KHpaYUwaSFyi6VGoOnk1aOJdDEW5jdmuQa8RzbAwyLYNN0t+ZvVDCQof2TybmKmm28Noh9Tdy3Os0hUqrvzJ8UdWBulPOgRddbhEjVhZrOyQNt9cklcGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762713084; c=relaxed/simple;
	bh=lagGB119Tu/XhLjie1igQzxEFLCFohx2cpKNVnUOTlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kB3e1U+m3lf8/bqGod2EgKtiowcPyhYQ3zhco+zEb02CnJcFruaA+ki/q5vsU0pnCXsbeC33TzBvzRzZOauBdxEZe7O99NcOfasdlNDd7N/X3DvaiSSFADmjJzXrJLUOZvS9EHZOERbc5sWQubjnIbAPUj67nznhDdczszWHr60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lY9C2OK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lY9C2OK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7236FC19423;
	Sun,  9 Nov 2025 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762713083;
	bh=lagGB119Tu/XhLjie1igQzxEFLCFohx2cpKNVnUOTlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lY9C2OK1pefNuZq9qoEtWD/xVlsBcqiqnBcn9ljopiR9Qw+zwStH9K++HY2aB7znu
	 si78raz+pysvmU8/m1WDAJ6bXEvcuLrdm73aijDPl5x9wyZE1y8g8Fb4jkBRpSzjW7
	 TEo65+HfsERGAB+MBOsnQ17I+yvq2pKrFLzc8CA5c4GWIA/APInHGnc4g7Ejer/hVz
	 H9pZ2/sDLEkOg74MeNX5oNQtbd+EIGphxFSAf5NfzOYejqBzd3wljGZJHlcBvri1sJ
	 Ih0h8zwi77ueRG8M41mwGNovRbKsGQ04jramX+/DY/3n7psMFS3HgXrCZRZdX5ZdAG
	 6mwoc82KD2pPg==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/13] sched_ext: Make handle_lockup() propagate scx_verror() result
Date: Sun,  9 Nov 2025 08:31:08 -1000
Message-ID: <20251109183112.2412147-10-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109183112.2412147-1-tj@kernel.org>
References: <20251109183112.2412147-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_lockup() currently calls scx_verror() but ignores its return value,
always returning true when the scheduler is enabled. Make it capture and return
the result from scx_verror(). This prepares for hardlockup handling.

Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Emil Tsalapatis <etsal@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5c75b0125dfe..4507bc4f0b5c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3658,6 +3658,7 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 {
 	struct scx_sched *sch;
 	va_list args;
+	bool ret;
 
 	guard(rcu)();
 
@@ -3669,9 +3670,9 @@ static __printf(1, 2) bool handle_lockup(const char *fmt, ...)
 	case SCX_ENABLING:
 	case SCX_ENABLED:
 		va_start(args, fmt);
-		scx_verror(sch, fmt, args);
+		ret = scx_verror(sch, fmt, args);
 		va_end(args);
-		return true;
+		return ret;
 	default:
 		return false;
 	}
-- 
2.51.1

