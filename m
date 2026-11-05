Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859411;
	b=UjUD4dLvUmO/UX9Yhxuqfo8m2uDcaUDdfOj7uNWKl6/UXUXrVa4tmYH80OQAu6B8wL1V
	 xkLXnTdaVslRADLIbW5bqbK9tzUALqPul+iGW9+HPraNXjpsVK3+iPsjP5yMj4NiWPtx2
	 tNYkXuHcu5lZfNOkGaFVuFDd2lYuuvVW8pLZ/smCbGFxJme//H2GpycOSH9H8DWDF36Iu
	 E9vhJpg9b48LshMVxzUqBGoOI1Eezs0WsAq+ua31F4RZhNkesU2bCwfw9RxQ8KefbRfX+
	 FGyE4SFuvy4QogD+WjDT2BKjo7Xku3gk1oF4IIUae1HoU9Ar6/7sBhHKX/ydfSkcL2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859411;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=Rtuq9eSTDy/EBy0lRw7H0h+4JxLcQbJ+OtXDpRKLhhI=;
	b=TGOwnt530BkJT3pG68zHQYTAUBxYMXmTPrEY1LGOnysE2cEg/73DEcN/iFvwZPFeEdtk
	 rvrQLP72My2EU4XNGHI9IvjnjMyq7ZSeWQOoPDsp9LfU3UKBSFaJvhc+HgHqCoLGdos0O
	 k+gSSJzpWGWGb20IuZYjRXF+I7JI0CbauWjAAOI8HPXR6c9OpLUaQKhjOE75WKil+3qss
	 0qDo3ZyCln86RRXnxAfwvGTot1hMhLGYin9JC22W8ZYFls0XVk4dD/GgCvtGoBt2VKPvx
	 CY6gdUEmdbiQxSLz2nSRPm5neOE1KgsITnBa61oQFpsZBx0rNCUGXN44yVso7gu0D3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=dNGhja+E;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837E7606A328
	for <sched-ext@lists.linux.dev>; Thu,  5 Nov 2026 06:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 837E7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=dNGhja+E
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Rtuq9eSTDy/EBy0lRw7H0h+4JxLcQbJ+OtXDpRKLhhI=;
	b=dNGhja+EtM5cwz6s8FD6mSOExzYYzOR1KF93AH6qAvt9A0sA4W/ORTRvu1FhiOUvrNpAoGHBt
	LiMjB7UDYQI6iiFQ9fHhwB95+FQb1YHLrbr2vPlbo/5tfaoqiTHduRFT9ViH22Y3gy/tnW0H3f6
	yW/Pv66j2lCzyDgXsL6HQS8=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jKsWp41nbz1T4Fq;
	Thu,  5 Nov 2026 14:16:22 +0800 (CST)
Received: from kwepemk300016.china.huawei.com (unknown [7.202.195.98])
	by mail.maildlp.com (Postfix) with ESMTPS id 7633640561;
	Thu,  5 Nov 2026 14:16:43 +0800 (CST)
Received: from huawei.com (10.67.174.191) by kwepemk300016.china.huawei.com
 (7.202.195.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 14:16:42 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: <sched-ext@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <tj@kernel.org>, <void@manifault.com>,
	<arighi@nvidia.com>, <changwoo@igalia.com>, <tanghui22@huawei.com>,
	<zhangqiao22@huawei.com>
Subject: [PATCH 0/4] sched_ext: Decompose scx_cid_init()
Date: Thu, 5 Nov 2026 14:50:09 +0800
Message-ID: <20261105065013.784398-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk300016.china.huawei.com (7.202.195.98)

scx_cid_init() grew into a ~230-line monolith interleaving table
allocation, the node/LLC/cluster/core topology walk, the no-topo tail
and the shard range finalization. This series decomposes it into stage
helpers sharing a file-private builder struct, in four individually
compilable steps:

  01/04 extract the no-topo tail and the table finalization
  02/04 collect the construction state in scx_cid_builder
  03/04 extract the construction of a single LLC cid range
  04/04 extract the online (node-level) walk

No behavior change: WARN checks, error paths, shard policy and
publication timing are all preserved. This is preparation for
follow-up fixes to the partial-SMT core counting in
calc_shard_layout() and the single-core shard hard-cap corner case,
which are deliberately kept out to keep this series a pure code
motion.

Based on tj/sched_ext for-7.5.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

Zhang Qiao (4):
  sched_ext: Extract no-topology CID construction and table finalization
  sched_ext: Collect CID construction state in a private builder
  sched_ext: Extract construction of a single LLC CID range
  sched_ext: Extract online CID construction from scx_cid_init

 kernel/sched/ext/cid.c | 422 +++++++++++++++++++++++------------------
 1 file changed, 241 insertions(+), 181 deletions(-)


base-commit: beb427129cbdd0154cdb017a694779963e46b520
-- 
2.43.0

