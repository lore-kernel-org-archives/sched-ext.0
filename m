Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D62E4E1C87;
	Mon, 28 Sep 2026 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616364; cv=none; b=Rf+4HvaRWvscMVsMWAR8KJFMtVneTjtqcoYC2Pf5FGUvTyJDCTeQ8ny5rhTGsRQFoSuqUGVAO1Z2yifvSd7mfEBgskMgT8Mu3BxLyn6qqNcWeVIzl8zZ04vXgbfCcv4SMPPH95SdBDLblXqT+FbBfoJ8xvLz8XmXOhkXb2F5VqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616364; c=relaxed/simple;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=g7n2+cXbUf2L2YjP4KbCkip2uWLhZW1sUjUClodv6dcyzF80xTcLQ8owIHYUpITUVRDGidp5oROJQgK51juT7/4xThnv27opQi2yaSvExMchwXolOWKCMLlMG6QlSPf56dQ5Ie+RTGsHnvXncd9iKeiUKyYxDuq2tshUgsxTl5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPNf0hGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPNf0hGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7731F000FF;
	Mon, 28 Sep 2026 17:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790616362;
	bh=IuPu+yMf9yB+vXg30wMwcp0KVm/4Ai9mZ7o97X7hE34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DPNf0hGzhRw4LyjfU2jQCciTyAlQ9OxWtHHDmJxWKYqu4elAdSJk3teqnrT09Z++/
	 aNCHCrxg7tu6Nj6DsgnP4qoonhd6QTSMwW4BdZ3AOtMmdH9BiiMZs8xcZX6/LmvRAD
	 xlVQrkC9/lAoxtZIQlohB/BLNUOCL7/G+8J867XFSQnp2zIBrpWHEDcxSNz1nggzec
	 sFx7kdejinL5CnQVTo0PYEjHK6NDcK9q+HQAbzD6HNMXIcE5wd2Y/3SMadp5JkfSZN
	 F7YMJ7T1SdB8Cz+sAvlTYIgDriarT6gxqEeX7eQrEzvs6Zqkn/jjb59lzXZ5mYooVN
	 IKUt3HoVhtLZA==
Date: Mon, 28 Sep 2026 07:26:01 -1000
Message-ID: <d9f8e00d70aa015cd2188bf8c62606f0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Fuyu Zhao <zhaofuyu@vivo.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
 David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/sched_ext: Add SCX_OPS_OPEN_OPTS for schedulers
 using open opts
In-Reply-To: <20260928030955.12353-1-zhaofuyu@vivo.com>
References: <20260928030955.12353-1-zhaofuyu@vivo.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.4.

Thanks.

--
tejun
