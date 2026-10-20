Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792456301;
	b=N3JbIUf0lgeiCnO2JdyYA3KXT26RzQnzhOeCgoq4eV9mkC+lOyZYiOUsk+VA4qhCINQG
	 r/Gacp9ss5SzcL65RtoqTyEDVcSozdjciCaFlf6NRY77aKOwMQnSC5oLbUAV0Q4lpLG7v
	 zPC4xDxgzlKFHbOq0iK9+MM2OIvquySqgeW9yqSOGw8heVtNsHNslfl+8uCNTibnGLuC8
	 U1z+M80HjkYre/z8YfLKhOKVaGjny3XiKEuvz6GUTOYWL5H76Rny2t6s+0Mh46Vpx5H33
	 6zGiNbteOJm9hFpC8T+cFpPrbuo2N4FHdNmSscoguhFNbd8aD5BNMAUPwy4Sa+Nv24Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792456301;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=751Y6zhqVlujoAmZVVL9yyvNp28mfGpF7nvRUspAqIc=;
	b=pCjoQzB5TioIGaMu3SapKm4AwodJKeWwHigLHb/pjzUZqi94UR5FvFZatshxqgzcm2CT
	 LvUhelH4lJ45rC71b4AtpmbegGucUssUciqysnbTCz9jgrfCofXcno6CNyH4juguwms9w
	 jjikm86Rr66SA1jihy1gpYrIYBI6hjd59C3Jy8jSM+QJYbRHk2uX9uKODYQfjSA0RtpH0
	 9nffeyADgVU0+mv/qDATsiErHBXxjYjOK4nZoQAE+y8g6ceqZZN6bcyZOITaHiE/oHnPw
	 AWq2sKA/wMOYxP/1GYpNCvuQwhxKd/pXg54zPgEjouNctE1OfdwS+Txoadj1PrQMRpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GXixBEC/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE3606A31A;
	Tue, 20 Oct 2026 00:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXixBEC/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00691F000C5;
	Tue, 20 Oct 2026 00:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792456301;
	bh=751Y6zhqVlujoAmZVVL9yyvNp28mfGpF7nvRUspAqIc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GXixBEC/r4jnwXB5/hHlBLU0pcxTo68MTZcS4HB1Blx3bHmcf0Q0eILL8DDNaEEkj
	 rZZA8QMw9liBZ8jQhI1oT71WrqVqCq9LbrxdfQwaZsyRQHBAidJjkSCvcrKlAoQbFi
	 uOKXSrhSE4hayvnQtDo66vKKmIwgad7z8XMBRDim8Ztt69xGMlCVjWQejLV1uRA4sy
	 hltA0Oygv91LZuVni42dx2A7g+7ObIXHlC0TX0LqI+7Y7JszQ4mQsbIGUDIapiso2N
	 wWbSlGUYjT6t4oZhonR0cn1f59wjbxhywq3srKoMECnkaqOjyJczZGZNbDN66NFWcx
	 IJ0gE/mNoPy8Q==
Date: Mon, 19 Oct 2026 14:31:40 -1000
Message-ID: <657547efeaea54276c50a0c106399366@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH sched_ext/for-7.4 0/5] sched_ext: Make ops.cpu_acquire/release() reliable
In-Reply-To: <20261019144807.1207781-1-jpiecuch@google.com>
References: <cover.1792248922.git.jpiecuch@google.com> <20261019144807.1207781-1-jpiecuch@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Hello, Kuba.

On Mon, Oct 19, 2026 at 02:48:05PM +0000, Kuba Piecuch wrote:
> Tejun, Peter, would a hook like this be acceptable? The core.c
> footprint is one line, it's a static branch when SCX isn't enabled, and
> the out-of-line call only happens when the pick goes to a class above
> SCX. If you're OK with it, I'd send the IMMED fix first, separately
> (Fixes: 98d709cba319 ("sched_ext: Implement SCX_ENQ_IMMED")), and
> rebase v2 of this series on top of it.

I don't really see a lot of utility in ops.cpu_acquire/release(). As it
currently stands, it doesn't add anything that can't be covered by IMMED,
and given how asynchronous the events are, I'm not sure an edge-triggered
view of CPU availability is particularly useful. IMMED works because it's
something the kernel can check and enforce. If there are holes in it,
let's plug them, but I don't think the holes justify keeping or updating
ops.cpu_acquire/release().

Can you please send the IMMED fixes separately?

Thanks.

--
tejun
