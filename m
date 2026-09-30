Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357E50EBE8;
	Wed, 30 Sep 2026 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812028; cv=none; b=l6spJRVwzXJMMgFtlDeJfdHhFY9LEqkVAKLNdmr0nphGF32HpU1Jr3sFCqjzGASuh+u7n6E+2gr6IVA/vhM2ycM9v4W1VoA5NDUYHmgMfozPBopmfuBEje4T6OgrPghr8awu8MlKkxepd2rBLA514EgvM+65n3LYKTDMjXcSG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812028; c=relaxed/simple;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=BkFxwwq6C8pgOZYfADV4O0LQwxaHm8bfLA/WkD7m2hosQmWo0gF6jMGcs0wt4mnbj79fVpXiIt4LWVf0VCpviyWJ1QIvFEDvcEcu3+Dcd56N0inJRMD887L8ntz35LT9psfQN8QnyhLQtg3qaUqEOw/lkhgrwQfuman3WYIz8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q27CbZ8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q27CbZ8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2251F1F000FF;
	Wed, 30 Sep 2026 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812026;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q27CbZ8AEtYibVp44Lxv63B7zC9o3O0aizDgbVL81lMrpNWZZkCnZtcOdWuRfRlA7
	 i9kjf5lj2/X9GHNFpUkqpSUv5L5XtWkogKe6HFA9V2nUvaBqruz6rGKbgS6+85+Mos
	 280l1AOo56RtOtDLvPFll4W0MkhObf505K3I2Wa+7b8ZzTF00MFV633ZE9s/JIgHo8
	 vUuMd/djJgwA/qw9OLtsE9SpS2vlTrV4oM+ovJNSP49a9LVrhUA1AhOPpOCKTHVyRi
	 1DXH69kv6XZ7SDWsLtV7U82jXhp7ugXODVcrsl0GwlAree6TTDlCVrTa3CoEAG2HPx
	 vuV0k+UugZ6TA==
Date: Wed, 30 Sep 2026 13:47:05 -1000
Message-ID: <38cd218666e72139f06ea0155b988722@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.4] sched_ext: Sync tools headers from
 the scx repo
In-Reply-To: <20260930000422.3350352-1-tj@kernel.org>
References: <20260930000422.3350352-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.4.

Thanks.

--
tejun
