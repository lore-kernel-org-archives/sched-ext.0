Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050442F90EA;
	Tue, 23 Sep 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646688; cv=none; b=LdLip/kL4bJGR/obd4vQ585V6e+VX3hX8JcxgVWN4lnmCalAGNFlTaaQTJI8LYA8h3L91FSXmi+fZudxq33wrXSyW2o7yvwJlUahzZe1eyxjh4uMhAh6pkenjFZpPgytcdbnfG9/Z0wqqA8GAVqMXGzTtAtjD5J+lYZ2vuH08aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646688; c=relaxed/simple;
	bh=HYOHE0McPDY47yfsjlPo4Q1qwy30vu2gr05sxVZe2a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkCF3wvd/LRUAcuvrNcfzO1AntWMwMm99EBzM2qSExxauJ33xFARqRNrAUiCmrYcf6arPOwCvB/Be/OIuuy8OKngiTq4YQcbNWkBON7gpka7KDTCPG2jdEUp6hshRIUV2T/L0agabhOBEOH5uL53KmuhkIU+d/8+bMrzBzZnqw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkZY03kM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkZY03kM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751C3C4CEF5;
	Tue, 23 Sep 2025 16:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758646687;
	bh=HYOHE0McPDY47yfsjlPo4Q1qwy30vu2gr05sxVZe2a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nkZY03kMvu79BIeItCRt49PZCoLa/OPckBBzxrDM0qlZkbs1s0s229Vr3Nuwz4K9R
	 jcElO39vp8Ofmi+dI+XSWvzvhgttWJeFW/lVEW7oYlR0cydpOv1qfliaTa8zSBvpxr
	 8RFVLdcixwwh29dKyatUxyRqPmrHMaqWD4PiGVGYyotaI7SDsgxThMV8YQAknY3MwV
	 J1tG1Ou7l3ixR99gtoDLdtZkr42AlbpSRu7eove0TWuvWGL4jqLMUDWCPnDE2uWMgw
	 yMNvBeFag9/M+6ZlmwwSuqwojvxc9T6qm+dnKOCrtBCJgV9G1aajlOENnyvQraMaLj
	 erMmUj53JPgaw==
Date: Tue, 23 Sep 2025 06:58:06 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: [PATCH v2 4/7] sched_ext: Use bitfields for boolean warning flags
Message-ID: <aNLRnjsWRQt4WjRM@slm.duckdns.org>
References: <20250922013246.275031-1-tj@kernel.org>
 <20250922013246.275031-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922013246.275031-4-tj@kernel.org>

Convert warned_zero_slice and warned_deprecated_rq in scx_sched struct to
single-bit bitfields. While this doesn't reduce struct size immediately,
it prepares for future bitfield additions.

v2: Update patch description.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_internal.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -871,8 +871,8 @@ struct scx_sched {
 	struct scx_dispatch_q	**global_dsqs;
 	struct scx_sched_pcpu __percpu *pcpu;
 
-	bool			warned_zero_slice;
-	bool			warned_deprecated_rq;
+	bool			warned_zero_slice:1;
+	bool			warned_deprecated_rq:1;
 
 	atomic_t		exit_kind;
 	struct scx_exit_info	*exit_info;
