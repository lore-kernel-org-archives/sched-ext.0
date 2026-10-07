Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF3023E330;
	Wed,  7 Oct 2026 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791333646; cv=none; b=mCdQT8jSBDZvWUkA2O1J0aQIVMMqOAh5X7NiCJugmSyPPS3jOHnlu+jvPTxlTG8lwoTJVAWPtOrYMMJIGrIzCSGt4JqiMeOn4Ppj32j/0aG9WPycPcrZrIG72JFilxJk4EWsnpOn0pyG2IqPPK0Lgt77o4vTFcQdTL8Yw+p3OTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791333646; c=relaxed/simple;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=aLkGi/8xCpK3tQWLZXrAnDqpKW47/0pVV5JNETpLzcVTzUpB9DtXOE1+Ohrx1zX5nGuGZEzltINZsxh1Pc6DRRwXYv9KhYNiAETPh5OOwf/YkywMq5FnDMoqOU1g4UTZgpF7cNLoMjiQetzRpI8MSDiBi1QSVrwdopG/ApHA5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPplBbrR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPplBbrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7551F0089B;
	Wed,  7 Oct 2026 00:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791333645;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oPplBbrR0DgEykjSlQIK+cW0K1NIfp4ywmH/AZLRFvxzaOj7cUQM5iAqH9235h6r/
	 6RJJJ+W5nwQV8fuuoTbKjRU9XjpRVt5vmFVRxH5FAsCfytlSpYbYXZ+NF8LMOpYKG6
	 PPff7EAO+dgMqgFkUXAEoY02dZyxoQllUKABta2SgPNE/d5OQcqvCMZRd3q2Ek6N/7
	 AOrNi283JJgJbU5+fj5Knl6BUs4b3a0Kvn/BazN6YFyQWn4AUfXQCkdAynvcX3D9Eh
	 aAUg8W2SkOZb6Hz+w8Erwekq3nzMv2VnM7zlmRmQrBBNL2S+dEDZpF250DyQkm1+51
	 Ni7kTQ1GO/kRA==
Date: Tue, 06 Oct 2026 14:40:44 -1000
Message-ID: <3871af99ba63dafea637284830f7a399@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.4] sched_ext: Add
 ops.sub_cid_sched_updated()
In-Reply-To: <20261005175520.2756986-1-tj@kernel.org>
References: <20261005175520.2756986-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.4.

Thanks.

--
tejun
