Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338865;
	b=T0M7y+4aLWqIGYeY1ysDqsDox3TC7e0sEGTXvzCUahwIOR+kqlaOvLvYnpbSsbVSpVl1
	 jCDYGHB9asxTFZ4ml6KzWfQhjWp0f/yzZcENnDc6CTkq6jvvoXYpcOSnkcL2zCA18glLz
	 l304FcwFrk/DRj9QTxFV0DKBMExbsMH4mNu55rFdSk5U6L9cU+Q7HC6VdGZtA0pc3Eq4F
	 m/NcKae8uw3Dkb0/xXhLSn3PClmW53mPS165PE9rdX8lIG6TJN3uQ7ztyLo3z8SAq2+PP
	 NuGvzuN1v6HMYqfQCw7u4+cNqMAXzHSk7n2q/krKLcV8C+gWp8hMLRIWsYZdC8cD4gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338865;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	b=wsQ6Kavn+UHTwdoCvBRSV8FcD7ZAdU/1Rr6xKYAf0h7hrUF/ysWfx7Y6BRAt/3T1Mzzr
	 tJ9jCyMsnUdlbKAM6ClEAk+bphjt2IH+PDg71u4ID7mSD/aaWffWW63YhVz6SwbJUx9/1
	 PK9i0fjb+LvDRhRUG+yBG59EGQHa7G2F8/1spCv8LYGn+jwNIJGYjvDAjk1zKSN1n5/P7
	 HXRufDA/CgZmPHO0Un4ne47dJ/IIRBknjqtrHAaKzGmObOj+jTY/Weu7Qb9RwMEf+qx3l
	 ohyb1LhKWxov7Lw0oA1yRIxvl0yTaOB1wXUU38tcWtLeeLF+sWt8uEEUX9YBaONWuyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f3s/fV+W";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C2606A321;
	Tue, 10 Nov 2026 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3s/fV+W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF1E1F0089F;
	Tue, 10 Nov 2026 19:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338864;
	bh=g8oRdUIPNrM19I+aRr6Xrjnpls3CINQLfjEu+H+Ojoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f3s/fV+WRKlAj5SFMK7jp5Iwb474odss6tdEMnEtGP+F94PUORxWyrsyZHO3RTFS/
	 Ct2fmiXzm8rHQlwcHeZd849h/CoI1qamUTDBN5xxyiCWNmKxZa0aScQVSF2ay85CjC
	 y4QCaDOJP5y3fixrJwabx/xNaMARegMfsn7kMNEUsIZ0DHWJeqvNQK8vYzpv9WMgU2
	 VgPCxysq/GkqfGXa/5FXg+DMSSn5e70rhdMSNkcS5gqnCGkiFZtYu87qNpxbExWDcl
	 LrZllyLGwPjfPnTW9CpLWKmk5j0IAkCmWy5ixm79WgAr6xLaMwdhCEiDrpA1q0mtKy
	 39w3eL8tQ2Ufw==
Date: Tue, 10 Nov 2026 09:27:44 -1000
Message-ID: <601db1ca092888f567aa98806ad47de9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, Hui Tang <tanghui20@huawei.com>
Subject: Re: [PATCH v2 sched_ext/for-7.4-fixes] sched_ext: Fix partial-SMT core counting in calc_shard_layout()
In-Reply-To: <20261110091042.1805197-1-zhangqiao22@huawei.com>
References: <20261110091042.1805197-1-zhangqiao22@huawei.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Applied to sched_ext/for-7.4-fixes.

Thanks.

--
tejun
