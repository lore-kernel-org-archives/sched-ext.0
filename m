Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787219;
	b=05kisLx72j44REmPVIJpsmuWKFlr2QF0KEbGyWT/GqaoVz3OJu0wV5xax+BId8b82s3G
	 Wof15TCmmzx8GBLYEGkXTalPnva0O50ZY493LoAhpJ+Y1xFx8geFx9TjAzdUXZWdTZjV2
	 4jGOG0sCpJT5V3eYYNQUCikEMQiKEVGl3tzirtGZnSuHcO2dQiBef685Ydvx5E6Wz4Yif
	 QM3DZxJhtJnO/a81V325fTOt1rpLcbBOfDg4Xkq1UkvddKJLZf7JAqS0WPLQ7EpU88ZHJ
	 O1M9yQWKHSuySG+13Xxe8PE4l9bBFBhniv0cfy7aFWJcPR2BXGIPvEvlI5HcP/VUz3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787219;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=sxyno1UwroxK9nFCSSP6D2QpXVK+BfG/kAuvqMrlWFg=;
	b=hXuUnp6fhu6mseXABarafBZuToAMs9/1zDMpqaqkQQPNk4xtV1fIoX9RhjIajxpqBy9P
	 DeLTn+reg82u7NX4ollH2zIa/ZPxsHmIri9sPDn9g2aQs7J+2Qm7ZoOOcO+G+nt43XOtI
	 bJp/S9gTOt/H6/npm68NR/fPK7mUjGstkvpwpV/NZI9jCNmSJwsal/Dv7MpLpVK+8fU6i
	 f5OvDEo29XqBGBDzEecApCbB90SCJYLSBemXbTfaR0lOPEOv4r/J3yQj8HJr0mFynizlL
	 NAxFqGsmQRSbSd331ZfaGXOB/PqFpArTTewXO3XGqJ0vG8SwucyptNcqWOlGeIoY2uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gT1itghq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3B606A323;
	Fri, 23 Oct 2026 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gT1itghq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897101F031E2;
	Fri, 23 Oct 2026 20:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792787218;
	bh=sxyno1UwroxK9nFCSSP6D2QpXVK+BfG/kAuvqMrlWFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gT1itghqfxIuFtox5VDHq+6lQxakKq2boy2ikIm8heOEyjqu4ivNElv5+bu4GHQOW
	 fVN9uu6jBOM7pNNt9gJgp/xpmorNU8A4fbZC51V/UoHhSQHuOxAPthapb5bukLo9Sg
	 Dq2ceSGo/zB3RXRX9icwy4JIQlD1XwMzPvsG5BtZYhlwIr6omMLJQ4BQjap/+L4H4E
	 5lih8gAqsXHVW7JQomSBbAM21/ngrhEpu89Jbv8NiHQL9+vZONQvV46pb2y4F79F34
	 AuAUYYrPn3wLZLpeUW20XY5Up2cM17tXQ36Xleor2vUH+24L3g01LwcQn0TZczozjf
	 doUzk33m8IrrQ==
Date: Fri, 23 Oct 2026 10:26:57 -1000
Message-ID: <4aa1f2d3a43d67ffcbba4eff0719e963@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.5] sched_ext: Regenerate the enum tables and drop scx_qmap's last compat lookup
In-Reply-To: <20261023000348.2726436-1-tj@kernel.org>
References: <20261023000348.2726436-1-tj@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

>  0001 sched_ext: Regenerate tools autogen enum headers
>  0002 sched_ext: scx_qmap: Read SCX_RESCUE_DISABLE through the enum lookup tables

Applied 1-2 to sched_ext/for-7.5 with the following tags added:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
