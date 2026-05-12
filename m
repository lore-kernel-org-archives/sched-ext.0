Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51CB4014A3
	for <sched-ext@lists.linux.dev>; Tue, 12 May 2026 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565420; cv=none; b=lpICA8Z0pXtAmg9wd3WeHXnDN5by5OrwYK5WSoBi97FnWUoS51qn+cIhDi4Vz2MIFhUQHi1NbgOnXShDQHD05Sjfw8jVnz79kuBR4h8N1Ee++QFnqzhGggzZotD+GdkGGxtVRYmd5UfPb7OwRq2LNs+IOThn/IczEGB4dNGloeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565420; c=relaxed/simple;
	bh=PEVkDx+h6dAL4n1ODSOCOw2//wltqWTU9G012mXgXmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZ5psfxSBwp9gSCMKKRIL7XQ3NuJb4lswmiAt17d9saTLuunv5+AKg62DKMhw0EFf5gQHPpqqDKBp36lSjGUjQKCXTPsA5wsBOG8g94ZG92M8ejf301dFccK5Jk+kQXJGUkmGT/a9+MslMHcMpiPa/fc73g/lF+pSe0I5lE8ICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=likewhatevs.io; spf=pass smtp.mailfrom=likewhatevs.io; dkim=pass (2048-bit key) header.d=likewhatevs.io header.i=@likewhatevs.io header.b=0sh1lprz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TEx8f8h3; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=likewhatevs.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=likewhatevs.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=likewhatevs.io header.i=@likewhatevs.io header.b="0sh1lprz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TEx8f8h3"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F4BE14000D7;
	Tue, 12 May 2026 01:56:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 12 May 2026 01:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=likewhatevs.io;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1778565401; x=1778651801; bh=MfRm5BoSWZ
	Zb0f/8pACjmHoh2eNoR97DUSZE8LG7Abc=; b=0sh1lprzMNscveLCtJUC4WLHRu
	mRIQQRqeJ4/wlNxKOkMtzA8E/HRPy6PsUtWjDko0zdOfWqbZAM6/w/JyWtEfQLTE
	LthXrqJMpt7WP71WbPt76E3WXBUy08nuWus0iUWDxCy2epZB7g6enjlt9N5GfDk/
	e+AnNyAbJmvtE8qBFBa5rSY6cOBz2o34kAkyEZPCROSqd7RaEcAWaf9Wv8seV0m6
	GYBvRPSyEvkAtWKJ39lofOogAU3Cb2CGA0ECwFdC6rKmoMGh+jueFZ6J/jpMXNWW
	d+q2972AvaO+w/mDh6X/njuEkubpFKCvileB+fO7jsMtH3w9I4QuAXxm5Hsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778565401; x=1778651801; bh=MfRm5BoSWZZb0f/8pACjmHoh2eNoR97DUSZ
	E8LG7Abc=; b=TEx8f8h3kThmBTsHAUa1wnWNiFsp1lF3hexppRcS0Z27DpF+Qd5
	C2jKekCFk9/XmTd3hFzK1Cfjp6l7oc12dm4AG5Mfu2+H2PFkCNeiyjwRjeTrTcna
	1o6GZWOX8LGXI88FcmdKRhFgAnf6+mypszX0odc886jCB9Dxq4sgkfK11ncLECne
	XRTUJy9RXt4dPx80Lavhvp1V/g54aQODKCB6ebfUTbWzjrn4LxNNnVHWaPyPxoCn
	EqMiGkgHi8kz68Ng7BXPMWH6swh/sqaGuy5cQLpP8Hjft+8DIj2xtP/dcHv+Ksi/
	5YbeMoUP6VOGVSAxOY9REnfJ3evvj3yCUWw==
X-ME-Sender: <xms:GcECanb6vddCnu3o1kBstcPqw8FL6V4eSvCrJlYNV8VNklKnKpO3Lw>
    <xme:GcECakO20ZwP9RPQ9EarucnSfEANJ9D48YyZqqjtCIU4FbiS4ii_zUoM3doQQk6we
    rvpJPVwJ6dJRkjXPelkK5u3wVrUZNS7V6TojQYWNorc5En1SWmG3Rpf>
X-ME-Received: <xmr:GcECakYCEPzPC6y_q2BKBjt9SZemYRjPO0uFvVC1QzgOuuP8n11-882wCEUTyQDZPbaQKFolzpFmcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddutddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefrrghtucfuohhmrghruhcuoehprghtshhosehlihhkvgifhhgrthgv
    vhhsrdhioheqnecuggftrfgrthhtvghrnhepfeevieevieejgfeutedtjeelleeifedvtd
    ekkeduudevteevuedtheffieeuhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphgrthhsoheslhhikhgvfihhrghtvghvshdrihhopdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtjheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepshgthhgvugdqvgigtheslhhishhtshdrlhhinh
    hugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehprghtshhosehlihhkvgifhhgrthgvvhhsrdhioh
X-ME-Proxy: <xmx:GcECaq0p-s_4Wu3ATr_bn2CwsdrylDY34gjCUudkuPWKAE-ueyo_3g>
    <xmx:GcECaidAXEhpsEUc8HnJRmAj7lAp1kUI8SOfgMkddbDAKbdYPpa_9Q>
    <xmx:GcECajFBC8IZSBrbLJKU59-inhYiZNxT3NMvJuEvbtFdI2QeiLwtsQ>
    <xmx:GcECar1am_Vv7X5f60mLbdZvqqdJg9ZzBTjHkcIcSzPleyKf-hbb4Q>
    <xmx:GcECasvHR6Uz4W85Y05WihNusEgROvYA05UBWBxAsCTVmDiIFxemhfKD>
Feedback-ID: i7f194913:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 01:56:41 -0400 (EDT)
From: Pat Somaru <patso@likewhatevs.io>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pat Somaru <patso@likewhatevs.io>
Subject: [PATCH] sched_ext: Add tracepoint for scheduler exit
Date: Tue, 12 May 2026 01:56:32 -0400
Message-ID: <20260512055632.1096713-1-patso@likewhatevs.io>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sched_ext schedulers have state in BPF programs and kernel. scx_dump
provides kernel state and BPF program state on error, but this is static
in what it can provide.

Add a sched_ext_exit tracepoint in scx_claim_exit() so that BPF programs
can dynamically inspect scheduler specific state at the moment of exit.

Signed-off-by: Pat Somaru <patso@likewhatevs.io>
---
 include/trace/events/sched_ext.h | 19 +++++++++++++++++++
 kernel/sched/ext.c               |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
index d1bf5acd59c5..9ccf884919c1 100644
--- a/include/trace/events/sched_ext.h
+++ b/include/trace/events/sched_ext.h
@@ -84,6 +84,25 @@ TRACE_EVENT(sched_ext_bypass_lb,
 	)
 );
 
+TRACE_EVENT(sched_ext_exit,
+
+	TP_PROTO(__u32 kind),
+
+	TP_ARGS(kind),
+
+	TP_STRUCT__entry(
+		__field(__u32, kind)
+	),
+
+	TP_fast_assign(
+		__entry->kind		= kind;
+	),
+
+	TP_printk("kind %u",
+		  __entry->kind
+	)
+);
+
 #endif /* _TRACE_SCHED_EXT_H */
 
 /* This part must be outside protection */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 64f8a096f133..0219b11bb9d1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6200,6 +6200,8 @@ static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
 	 */
 	WRITE_ONCE(sch->aborting, true);
 
+	trace_sched_ext_exit(kind);
+
 	/*
 	 * Propagate exits to descendants immediately. Each has a dedicated
 	 * helper kthread and can run in parallel. While most of disabling is
-- 
2.54.0

